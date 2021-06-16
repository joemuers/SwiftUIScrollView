//
//  LinearDragGesture.swift
//  SwiftUIScrollView
//

import SwiftUI

typealias DragChangedEvent = (_ translation: CGFloat) -> Void
typealias DragEndedEvent = (_ translation: CGFloat, _ duration: TimeInterval) -> Void

extension View {
    
    func linearDragGesture(_ axis: Axis,
                           onChanged: DragChangedEvent? = nil,
                           onEnded: @escaping DragEndedEvent) -> some View {
        
        self.modifier(LinearDragGesture(axis: axis, onChanged: onChanged, onEnded: onEnded))
    }
}

// MARK: -

private struct LinearDragGesture: ViewModifier {
    
    let axis: Axis
    let onChanged: DragChangedEvent?
    let onEnded: DragEndedEvent
    
    private struct Constants {
        static let axisDeterminationDistance: CGFloat = 10
        
        static let angleUpRight: CGFloat = 45
        static let angleDownRight: CGFloat = 135
        static let angleDownLeft: CGFloat = 225
        static let angleUpLeft: CGFloat = 315
    }
    
    private enum DragState {
        case idle, active(startTime: TimeInterval), ignored
    }
    
    @State private var dragState = DragState.idle
    
    func body(content: Content) -> some View {
        
        content
            .simultaneousGesture(DragGesture(minimumDistance: Constants.axisDeterminationDistance,
                                             coordinateSpace: .local)
                                    
                                    .onChanged({ value in
                                        
                                        switch self.dragState {
                                            case .ignored:
                                                return
                                            case .idle:
                                                guard self.isValidAngle(for: value) else {
                                                    self.dragState = .ignored
                                                    return
                                                }
                                                self.dragState = .active(startTime: value.time.timeIntervalSinceReferenceDate)
                                                fallthrough
                                            case .active:
                                                self.onChanged?(self.translation(of: value))
                                        }
                                    })
                                    
                                    .onEnded({ value in
                                        
                                        defer {
                                            self.dragState = .idle
                                        }
                                        
                                        if case .active(let startTime) = self.dragState {
                                            self.onEnded(self.endTranslation(of: value),
                                                         self.duration(of: value, startTime: startTime))
                                        }
                                    }))
    }
    
    private func isValidAngle(for value: DragGesture.Value) -> Bool {
        
        let angle = value.startLocation.angle(to: value.location)
        
        switch self.axis {
            case .horizontal:
                // Note - if changing, be careful with the numerical values of the angles here.
                return (Constants.angleUpRight < angle && angle < Constants.angleDownRight) ||
                    (Constants.angleDownLeft < angle && angle < Constants.angleUpLeft)
            case .vertical:
                return Constants.angleUpLeft < angle || angle < Constants.angleUpRight ||
                    (Constants.angleDownRight < angle && angle < Constants.angleDownLeft)
        }
    }
    
    private func translation(of value: DragGesture.Value) -> CGFloat {
        switch self.axis {
            case .horizontal:
                return value.translation.width
            case .vertical:
                return value.translation.height
        }
    }
    
    private func endTranslation(of value: DragGesture.Value) -> CGFloat {
        switch self.axis {
            case .horizontal:
                return value.predictedEndTranslation.width
            case .vertical:
                return value.predictedEndTranslation.height
        }
    }
    
    private func duration(of value: DragGesture.Value, startTime: TimeInterval) -> TimeInterval {
        let endTime = value.time.timeIntervalSinceReferenceDate
        guard endTime >= startTime else {
            assertionFailure("startTime \(startTime) is after endTime \(endTime)")
            return 0
        }
        return endTime - startTime
    }
}

// MARK: -

private extension CGPoint {
    
    func angle(to other: CGPoint) -> CGFloat {
        let deltaY = self.y - other.y
        let deltaX = other.x - self.x
        
        let rads = atan2(deltaX, deltaY)
        let result = rads * (180 / .pi)
        
        if result < 0 {
            return result + 360
        } else {
            return result
        }
    }
}

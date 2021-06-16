//
//  CustomScrollView.swift
//  SwiftUIScrollView
//

import SwiftUI

/// Purpose of this class is for the cases where we need scrollable behaviour but require more customisation than the
/// SwiftUI native ScrollView allows.
/// Note that it doesn't have scroll bars or inertial damping behaviour.
/// If you don't require such customisation then please prefer the regular ScrollView.
struct CustomScrollView<Content: View>: View {
    
    private struct Constants {
        static var offEdgeDampingFactor: CGFloat { 6 }
    }
    
    private struct ContentSize: Equatable {
        var bounds: CGSize? = nil
        let isVertical: Bool
    }
    
    private struct ContentLengthKey: PreferenceKey {
        static var defaultValue: ContentSize { ContentSize(isVertical: true) }
        
        static func reduce(value: inout ContentSize, nextValue: () -> ContentSize) {
            guard let current = value.bounds else {
                value.bounds = nextValue().bounds
                return
            }
            if let next = nextValue().bounds {
                if value.isVertical {
                    value.bounds = CGSize(width: max(current.width, next.width),
                                          height: current.height + next.height)
                } else {
                    value.bounds = CGSize(width: current.width + next.width,
                                          height: max(current.height, next.height))
                }
            }
        }
    }
    
    // MARK: -
    
    private let axis: Axis
    private let content: () -> Content
    
    @State private var contentSize: CGSize = .zero
    private var contentLength: CGFloat {
        return self.isAxisVertical ? self.contentSize.height : self.contentSize.width
    }
    @State private var dragOffset: CGFloat = 0
    @State private var baseOffset: CGFloat = 0
    
    init(_ axis: Axis = .vertical,
         @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            
            self.contentHolderView(geo: geo)
                .onPreferenceChange(ContentLengthKey.self) {
                    guard let bounds = $0.bounds else { return }
                    self.contentSize = bounds
                }
                .offset(x: self.isAxisVertical ? 0 : self.contentOffset,
                        y: self.isAxisVertical ? self.contentOffset : 0)
                .animation(.interactiveSpring(), value: self.dragOffset)
                .animation(.easeOut, value: self.baseOffset)
                .frame(width: self.isAxisVertical ? geo.size.width : nil,
                       height: self.isAxisVertical ? nil : geo.size.height)
                .clipped()
                .linearDragGesture(self.axis) { translation in
                    
                    self.dragOffset = self.dragOffset(from: translation, geometry: geo)
                    
                } onEnded: { translation, _ in
                    self.onDragEnded(translation: translation, geo: geo)
                }
        }
        .frame(maxWidth: self.isAxisVertical ? self.contentSize.width : nil,
               maxHeight: self.isAxisVertical ? nil : self.contentSize.height)
        .clipped()
    }
    
    private var isAxisVertical: Bool {
        switch self.axis {
            case .horizontal:
                return false
            case .vertical:
                return true
        }
    }
    
    private var contentOffset: CGFloat {
        return self.dragOffset + self.baseOffset
    }
    
    @ViewBuilder
    private func contentHolderView(geo: GeometryProxy) -> some View {
        
        switch self.axis {
            case .horizontal:
                HStack(spacing: 0) {
                    self.content()
                        .fixedSize(horizontal: true, vertical: true)
                        .background(
                            GeometryReader { proxy in
                                Color.clear.preference(key: ContentLengthKey.self,
                                                       value: ContentSize(bounds: proxy.size, isVertical: false))
                            })
                }
            case .vertical:
                VStack(spacing: 0) {
                    self.content()
                        .fixedSize(horizontal: true, vertical: true)
                        .background(
                            GeometryReader { proxy in
                                Color.clear.preference(key: ContentLengthKey.self,
                                                       value: ContentSize(bounds: proxy.size, isVertical: true))
                            })
                }
        }
    }
    
    private func dragOffset(from translation: CGFloat, geometry: GeometryProxy) -> CGFloat {
        
        let translationPosition = translation + self.baseOffset
        let maxScroll = self.maxScrollLength(geo: geometry)
        
        if translationPosition > 0 {
            let diff = translationPosition
            return (translation - diff) + (diff / Constants.offEdgeDampingFactor)
        } else if  -(translationPosition) > maxScroll {
            let diff = translationPosition + maxScroll
            return (translation - diff) + (diff / Constants.offEdgeDampingFactor)
        }
        
        return translation
    }
    
    private func onDragEnded(translation: CGFloat, geo: GeometryProxy) {
        defer {
            self.dragOffset = 0
        }
        
        let offsetResult = self.baseOffset + translation
        guard offsetResult < 0 else {
            self.baseOffset = 0
            return
        }
        
        let maxScroll = self.maxScrollLength(geo: geo)
        
        if -(offsetResult) > maxScroll {
            self.baseOffset = -(maxScroll)
        } else {
            self.baseOffset = offsetResult
        }
    }
    
    private func maxScrollLength(geo: GeometryProxy) -> CGFloat {
        let boundsLength = self.isAxisVertical ? geo.size.height : geo.size.width
        let result = self.contentLength - boundsLength
        return max(result, 0)
    }
}


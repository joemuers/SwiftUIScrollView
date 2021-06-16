//
//  CustomScrollView.swift
//  SwiftUIScrollView
//

import SwiftUI

struct CustomScrollView<Content: View>: View {
    
    private struct Constants {
        static var offEdgeDampingFactor: CGFloat { 6 }
    }
    
    private struct ContentLengthKey: PreferenceKey {
        static var defaultValue: CGFloat { 0 }
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = value + nextValue()
        }
    }
    
    // MARK: -
    
    private let axis: Axis
    private let content: () -> Content
    
    @State private var contentLength: CGFloat = 0
    @State private var dragOffset: CGFloat = 0
    @State private var baseOffset: CGFloat = 0
    
    init(axis: Axis, contentSize: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            
            self.contentHolderView(geo: geo)
                .onPreferenceChange(ContentLengthKey.self) { self.contentLength = $0 }
                .offset(x: self.isAxisVertical ? 0 : self.contentOffset,
                        y: self.isAxisVertical ? self.contentOffset : 0)
                .animation(.interactiveSpring(), value: self.dragOffset)
                .animation(.easeOut, value: self.baseOffset)
                .frame(width: self.isAxisVertical ? geo.size.width : nil,
                       height: self.isAxisVertical ? nil : geo.size.height)
                .clipped()
                .linearDragGesture(self.axis) { translation in
                    
                    self.dragOffset = self.offset(from: translation, geometry: geo)
                    
                } onEnded: { translation, _ in
                    self.onDragEnded(translation: translation, geo: geo)
                }
        }
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
                                Color.clear.preference(key: ContentLengthKey.self, value: proxy.size.width)
                            })
                }
            case .vertical:
                VStack(spacing: 0) {
                    self.content()
                        .fixedSize(horizontal: true, vertical: true)
                        .background(
                            GeometryReader { proxy in
                                Color.clear.preference(key: ContentLengthKey.self, value: proxy.size.height)
                            })
                }
        }
    }
    
    
    
    private func offset(from translation: CGFloat, geometry: GeometryProxy) -> CGFloat {
        
        let translationPosition = translation + self.baseOffset
        
        if translationPosition > 0 {
            print("damping 1")
            return translation /// Constants.offEdgeDampingFactor
        } else if -(translationPosition) > self.maxScrollLength(geo: geometry){
            print("damping 2")
            return translation /// Constants.offEdgeDampingFactor
        }
        
        return translation
    }
    
    private func onDragEnded(translation: CGFloat, geo: GeometryProxy) {
        defer {
            self.dragOffset = 0
        }
        
        let offsetResult = self.baseOffset + self.offset(from: translation, geometry: geo)
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

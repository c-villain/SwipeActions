//
//  MeasureWidthModifier.swift
//  
//
//  Created by Alexander Kraev on 24.12.2021.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value = nextValue()
  }
}

struct MeasureWidthModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(GeometryReader { geometry in
      Color.clear.preference(key: WidthPreferenceKey.self,
                             value: geometry.size.width)
    })
  }
}

extension View {
  func measureWidth(perform action: @escaping (CGFloat) -> Void) -> some View {
    self.modifier(MeasureWidthModifier())
      .onPreferenceChange(WidthPreferenceKey.self, perform: action)
  }
}

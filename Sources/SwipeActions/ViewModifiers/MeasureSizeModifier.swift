//
//  MeasureSizeModifier.swift
//  
//
//  Created by Alexander Kraev on 24.12.2021.
//

import SwiftUI

struct PreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: CGRect = .zero

  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
      value = nextValue()
  }
}

struct MeasureSizeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(GeometryReader { geometry in
      Color.clear.preference(key: PreferenceKey.self,
                             value: geometry.size)
    })
  }
}

extension View {
  func measureSize(perform action: @escaping (CGRect) -> Void) -> some View {
    self.modifier(MeasureWidthModifier())
      .onPreferenceChange(WidthPreferenceKey.self, perform: action)
  }
}

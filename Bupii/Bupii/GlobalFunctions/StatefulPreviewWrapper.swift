//
//  StatefulPreviewWrapper.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 02/05/2025.
//

import Foundation
import SwiftUI

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

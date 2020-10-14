//
//  BindingProvider.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/13/20.
//

import SwiftUI

struct BindingProvider<StateT, Content: View>: View {

    @State private var state: StateT
    private var content: (_ binding: Binding<StateT>) -> Content

    init(_ initialState: StateT, @ViewBuilder content: @escaping (_ binding: Binding<StateT>) -> Content) {
        self.content = content
        self._state = State(initialValue: initialState)
    }

    var body: some View {
        self.content($state)
    }
}

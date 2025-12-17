//
//  ViewKeyboard.swift
//  MyProperty
//
//  Created by Maurício Fonseca on 16/12/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

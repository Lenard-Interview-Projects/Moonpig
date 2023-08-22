//
//  ViewOffsetKey.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 22/08/2023.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

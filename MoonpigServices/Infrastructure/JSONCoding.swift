//
//  JSONCoding.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 19/08/2023.
//

import Foundation

@propertyWrapper
struct JSONCoding<T: Codable> {
    var wrappedValue: T

    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(T.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

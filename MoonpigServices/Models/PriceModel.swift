//
//  PriceModel.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

public struct PriceModel: Codable {
    public let value: Float
    public let currency: String

    public var priceDisplay: String {
        let formattedValue = String(format: "%.2f", value)
        return "\(currency)\(formattedValue)"
    }

    private enum CodingKeys: String, CodingKey {
        case value = "Value"
        case currency = "Currency"
    }
}

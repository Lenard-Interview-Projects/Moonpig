//
//  SearchResponseModel.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

import Foundation

public struct SearchResponseModel: Codable {
    public let searchId: String
    public let numberOfProducts: Int
    public let start: Int
    public let products: [ProductModel]

    enum CodingKeys: String, CodingKey {
        case searchId = "SearchId"
        case numberOfProducts = "NumberOfProducts"
        case start = "Start"
        case products = "Products"
    }
}

//
//  ProductCategoryModel.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

public struct ProductCategoryModel: Codable {
    public let productCategoryId: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case productCategoryId = "ProductCategoryId"
        case name = "Name"
    }
}

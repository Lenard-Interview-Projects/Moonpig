//
//  ProductModel.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

import Foundation

public struct ProductModel: Codable {
    public let price: PriceModel
    public let soldOut: Int
    public let title: String
    public let productCategory: ProductCategoryModel
    public let photoUploadCount: Int
    public let cardShopId: Int
    public let directSmile: Bool
    public let defaultSizeId: Int
    public let productId: Int
    public let moonpigProductNo: String
    public let tradingFaces: Int
    public let isLandscape: Int
    public let shortDescription: String
    public let description: String
    public let isCustomisable: Int
    public let isMultipack: Int
    public let seoPath: String
    public let productCategoryGroupSeoPath: String
    public let productLink: ProductLinkModel
    public let productImage: ProductImageModel
    public let reviews: ReviewsModel
    public let additionalProductImages: [ProductImageModel]

    private enum CodingKeys: String, CodingKey {
        case price = "Price"
        case soldOut = "SoldOut"
        case title = "Title"
        case productCategory = "ProductCategory"
        case photoUploadCount = "PhotoUploadCount"
        case cardShopId = "CardShopId"
        case directSmile = "DirectSmile"
        case defaultSizeId = "DefaultSizeId"
        case productId = "ProductId"
        case moonpigProductNo = "MoonpigProductNo"
        case tradingFaces = "TradingFaces"
        case isLandscape = "IsLandscape"
        case shortDescription = "ShortDescription"
        case description = "Description"
        case isCustomisable = "IsCustomisable"
        case isMultipack = "IsMultipack"
        case seoPath = "SeoPath"
        case productCategoryGroupSeoPath = "ProductCategoryGroupSeoPath"
        case productLink = "ProductLink"
        case productImage = "ProductImage"
        case reviews = "Reviews"
        case additionalProductImages = "AdditionalProductImages"
    }
}

//
//  ProductImageModel.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

public struct ProductImageModel: Codable {
    public let link: ProductLinkModel
    public let mimeType: String

    private enum CodingKeys: String, CodingKey {
        case link = "Link"
        case mimeType = "MimeType"
    }
}

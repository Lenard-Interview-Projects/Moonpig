//
//  ProductLinkModel.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

public struct ProductLinkModel: Codable {
    public let href: String
    public let method: String
    public let rel: String
    public let title: String

    private enum CodingKeys: String, CodingKey {
        case href = "Href"
        case method = "Method"
        case rel = "Rel"
        case title = "Title"
    }
}

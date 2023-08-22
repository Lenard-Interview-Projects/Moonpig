//
//  ReviewsModel.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

public struct ReviewsModel: Codable {
    public let minReviewData: Int?
    public let maxReviewData: Int?
    public let averageStarReviewRating: Float?
    public let reviewCount: Int?

    public var reviewDisplay: String {
        let formattedValue = String(format: "%.2f", averageStarReviewRating ?? 0.0)
        return "\(formattedValue) | \(reviewCount ?? 0)"
    }

    private enum CodingKeys: String, CodingKey {
        case minReviewData = "MinReviewData"
        case maxReviewData = "MaxReviewData"
        case averageStarReviewRating = "AverageStarReviewRating"
        case reviewCount = "ReviewCount"
    }
}

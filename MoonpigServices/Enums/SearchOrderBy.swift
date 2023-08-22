//
//  SearchOrderBy.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 22/08/2023.
//

import Foundation

public enum SearchOrderBy {
    case Popularity
    case New
    case PriceLow
    case PriceHigh

    public func equal(to otherType: SearchOrderBy) -> Bool {
        return self == otherType
    }
}

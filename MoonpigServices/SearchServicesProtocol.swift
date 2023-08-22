//
//  SearchServicesProtocol.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

import Foundation
import Combine

public protocol SearchServicesProtocol {
    func fetchResults(searchQuery: String, pageSize: Int, offSet: Int, orderBy: SearchOrderBy) -> AnyPublisher<SearchResponseModel, Error>
}

//
//  SearchServices.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 18/08/2023.
//

import Foundation
import Combine

public final class SearchServices: SearchServicesProtocol {
    private var networking: NetworkingProtocol = Networking()

    public init() { }

    public convenience init(networking: NetworkingProtocol) {
        self.init()
        
        self.networking = networking
    }

    public func fetchResults(searchQuery: String = "",
                             pageSize: Int = 0,
                             offSet: Int = 0,
                             orderBy: SearchOrderBy = .Popularity) -> AnyPublisher<SearchResponseModel, Error> {
        return networking
            .fetchData(url: "https://moonpig.github.io/tech-test-frontend/search.json")
            .map { (data: SearchResponseModel) in
                var products = data.products

                products = self.orderArrayByType(products, orderBy: orderBy)
                products = self.filterArrayByQuery(products, query: searchQuery)
                products = self.offSetArray(products, pageSize: pageSize, offSet: offSet)

                let pagedResult = SearchResponseModel(searchId: data.searchId,
                                                      numberOfProducts: data.numberOfProducts,
                                                      start: data.start,
                                                      products: products)

                return pagedResult
            }
            .eraseToAnyPublisher()
    }

    /*
     The following methods are purely to fake a more advanced API
        - We can sord the data returned
        - We can filter the data by text through the title
        - We can return only a specific page size and fake pagination
     */
    private func orderArrayByType(_ products: [ProductModel], orderBy: SearchOrderBy) -> [ProductModel] {
        guard !products.isEmpty else { return products }

        switch orderBy {
        case .Popularity, .New:
            return products
        case .PriceHigh:
            return products.sorted { $0.price.value > $1.price.value }
        case .PriceLow:
            return products.sorted { $0.price.value < $1.price.value }
        }
    }

    private func filterArrayByQuery(_ products: [ProductModel], query: String) -> [ProductModel] {
        guard !query.isEmpty else { return products }
        guard !products.isEmpty else { return products }
        
        return products.filter { $0.title.lowercased().contains(query.lowercased()) }
    }

    private func offSetArray(_ products: [ProductModel], pageSize: Int, offSet: Int) -> [ProductModel] {
        guard pageSize != 0 else { return products }
        guard !products.isEmpty else { return products }

        if products.count > (offSet + pageSize)
        {
            return Array(products[offSet..<(offSet + pageSize)])
        }
        else
        {
            return Array(products[offSet..<products.count])
        }
    }
}

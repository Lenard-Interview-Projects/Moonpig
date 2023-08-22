//
//  MockNetworkingProtocol.swift
//  MoonpigServices
//
//  Created by Lenard Pop on 23/08/2023.
//

import Foundation
import Combine

public class MockNetworking: NetworkingProtocol {
    private let mockData: Data

    init(mockData: Data) {
        self.mockData = mockData
    }

    public func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        let publisher = Just(mockData)
            .setFailureType(to: Error.self)
            .decode(type: T.self, decoder: JSONDecoder())

        return publisher.eraseToAnyPublisher()
    }
}

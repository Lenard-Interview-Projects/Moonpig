//
//  SearchViewModelTests.swift
//  moonpig-interviewTests
//
//  Created by Lenard Pop on 23/08/2023.
//

import Foundation
import XCTest
import MoonpigServices
@testable import moonpig_interview

class SearchViewModelTests: XCTestCase {

    var searchService: MockSearchServices!
    var viewModel: SearchViewModel!

    override func setUp() {
        self.searchService = MockSearchServices()
        self.viewModel = SearchViewModel(searchService: searchService)
    }

    func test_initial_values() throws {
        // Arrange
        // Act
        // Assert
        XCTAssertEqual(0, viewModel.searchResults.count)
        XCTAssertEqual("", viewModel.searchQuery)
        XCTAssertEqual(0, viewModel.numberOfResults)
        XCTAssertEqual(SearchOrderBy.Popularity, viewModel.orderBy)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingSearchResults_noErrors() throws {
        // Arrange
        let searchResponse: SearchResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "MoonPigSearchResponseResults")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not read contents of file")
            return
        }

        searchService.withResult(searchResponseModel: searchResponse)

        // Act
        viewModel.fetchSearchResults()

        // Assert
        XCTAssertEqual(13226, viewModel.numberOfResults)
        XCTAssertEqual(14, viewModel.searchResults.count)

        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingSearchResults_errorFound() throws {
        // Arrange
        searchService.withError()

        // Act
        viewModel.fetchSearchResults()

        // Assert
        XCTAssertEqual(0, viewModel.numberOfResults)
        XCTAssertEqual(0, viewModel.searchResults.count)

        XCTAssertTrue(viewModel.errorFound)
        XCTAssertTrue(viewModel.isInitialized)
        
        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func test_filter_priceHigh_fetchSearchResults() throws {
        // Arrange
        let searchResponse: SearchResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "MoonPigSearchResponseResultsPriceHigh")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not read contents of file")
            return
        }

        searchService.withResult(searchResponseModel: searchResponse)

        // Act
        viewModel.filterSearchResults(type: .PriceHigh)

        // Assert
        XCTAssertEqual(SearchOrderBy.PriceHigh, viewModel.orderBy)
        XCTAssertEqual(20, viewModel.searchResults.count)
        XCTAssertGreaterThan(viewModel.searchResults[0].price.value, viewModel.searchResults[1].price.value)
        XCTAssertTrue(viewModel.canLoadMore)
    }

    func test_filter_priceLow_fetchSearchResults() throws {
        // Arrange
        let searchResponse: SearchResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "MoonPigSearchResponseResultsPriceLow")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not read contents of file")
            return
        }

        searchService.withResult(searchResponseModel: searchResponse)

        // Act
        viewModel.filterSearchResults(type: .PriceHigh)

        // Assert
        XCTAssertEqual(SearchOrderBy.PriceHigh, viewModel.orderBy)
        XCTAssertEqual(20, viewModel.searchResults.count)
        XCTAssertLessThan(viewModel.searchResults.first?.price.value ?? 0.0, viewModel.searchResults.last?.price.value ?? 0.0)
        XCTAssertTrue(viewModel.canLoadMore)
    }
}

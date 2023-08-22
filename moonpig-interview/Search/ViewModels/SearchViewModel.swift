//
//  SearchViewModel.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 21/08/2023.
//

import Foundation
import Combine
import MoonpigServices

class SearchViewModel: ObservableObject {
    @Published var searchResults: [ProductModel] = []
    @Published var searchQuery: String = ""
    @Published var orderBy: SearchOrderBy = .Popularity
    @Published var numberOfResults: Int = 0

    @Published var isLoading = false
    @Published var isInitialized = false
    @Published var isEmpty = false
    @Published var canLoadMore = false
    @Published var errorFound = false

    private var cancellables: Set<AnyCancellable> = []
    private let pageSize = 20
    private let searchService: SearchServicesProtocol?

    var isReady: Bool { return !isLoading && isInitialized == true }
    var isEmptyOrError: Bool { return isEmpty || errorFound }
    var shouldDisplaySearch: Bool { return isEmpty && searchQuery.isEmpty && !isLoading }

    init(searchService: SearchServicesProtocol) {
        self.searchService = searchService
    }

    convenience init(searchService: SearchServicesProtocol, isLoading: Bool, isInitialized: Bool, isEmpty: Bool) {
        self.init(searchService: searchService)
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }

    func loadMore() {
        if isLoading { return }

        isLoading = true

        fetchResultsFromService()
    }

    func fetchSearchResults() {
        if isInitialized { return }
        if isLoading { return }

        isLoading = true

        fetchResultsFromService()
    }

    func searchQueryListener() {
        $searchQuery
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { string in
                return string.isEmpty
            }
            .sink { [weak self] isEmpty in
                guard let self = self else { return }

                if self.isLoading { return }

                self.isLoading = true
                self.searchResults.removeAll()
                self.fetchResultsFromService()
            }
            .store(in: &cancellables)
    }

    func filterSearchResults(type: SearchOrderBy) {
        if isLoading { return }

        isLoading = true

        orderBy = type
        searchQuery = ""
        searchResults.removeAll()
        fetchResultsFromService()
    }

    func reset() {
        searchResults.removeAll()
        searchQuery = ""
        orderBy = .Popularity
        numberOfResults = 0

        isLoading = false
        isInitialized = false
        isEmpty = false
        canLoadMore = false
    }

    private func fetchResultsFromService() {
        var cancellables: AnyCancellable?

        // I have assigned the publisher to a cancellable and then cancelled it at the end of consuming the data because deinit will never be called since we only have 1 page
        cancellables = searchService?
            .fetchResults(searchQuery: searchQuery, pageSize: pageSize, offSet: searchResults.count, orderBy: orderBy)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .finished:
                    self.errorFound = false
                    break
                case .failure(_):
                    // Log the error into something like Firebase/Sentry
                    self.errorFound = true
                    self.isLoading = false
                    self.isInitialized = true
                }

                cancellables?.cancel()

            }, receiveValue: { [weak self] (data: SearchResponseModel) in
                guard let self = self else { return }

                self.searchResults.append(contentsOf: data.products)

                self.isEmpty = self.searchResults.isEmpty
                self.canLoadMore = !data.products.isEmpty && data.products.count >= self.pageSize
                
                self.numberOfResults = data.numberOfProducts

                self.isLoading = false
                self.isInitialized = true
                self.errorFound = false
            })
    }
}

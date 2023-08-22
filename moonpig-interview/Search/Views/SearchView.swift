//
//  SearchView.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 21/08/2023.
//

import SwiftUI
import MoonpigServices

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel

    @State private var currentOffset: CGFloat = 0
    @State private var searchBarVisibility: Double = 1.0

    private let minimumOffset: CGFloat = 16
    private var columnGrid = [GridItem(.flexible(),
                                       spacing: 16,
                                       alignment: .top),
                              GridItem(.flexible(),
                                       spacing: 16,
                                       alignment: .top)]

    init(searchService: SearchServicesProtocol) {
        _viewModel = .init(wrappedValue: SearchViewModel(searchService: searchService))
    }

    /** WhatNext
        Again with introspect we would get rid of this
     */
    private func scrollDirectionToDisplaySearch(input: CGFloat) {
        let offsetDifference: CGFloat = abs(self.currentOffset - input)

        if self.currentOffset > input || self.currentOffset == input {
            withAnimation(.easeInOut) {
                searchBarVisibility = 1
            }
        }
        else {
            withAnimation(.easeInOut) {
                searchBarVisibility = 0.0
            }
        }

        if self.currentOffset < 0 && self.currentOffset < input {
            withAnimation(.easeInOut) {
                searchBarVisibility = 1.0
            }
        }

        if offsetDifference > minimumOffset {
            self.currentOffset = input
        }
    }

    /*
     We inserted 2 spacer in order to push the items down to fit the search bar so that it doesn't overlap with the top most items
     Padding was not an option as it would break the navigation display mode
    */
    private func fakeTopItems() -> some View {
        return Group {
            Spacer()
                .frame(height: 50)
            Spacer()
                .frame(height: 50)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        if viewModel.isEmptyOrError {
                            VStack {
                                Image(viewModel.errorFound ? "error_found_image" : "no_cards_image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 350)
                                
                                Text("Please pull to refresh")
                                    .font(.title)
                                    .fontWeight(.light)
                            }
                            .padding(.top, 32)
                        }
                        else {
                            LazyVGrid(columns: columnGrid, spacing: 16) {
                                if viewModel.isInitialized == false {
                                    ForEach(0..<4, id:\.self) { index in
                                        SearchItemView(title: "",
                                                       category: "",
                                                       imageUrl: "",
                                                       price: "",
                                                       review: "")
                                        .redacted(reason: .placeholder)
                                    }
                                }

                                if viewModel.isInitialized {
                                    fakeTopItems()

                                    ForEach(viewModel.searchResults, id:\.productId) { product in
                                        SearchItemView(title: product.title,
                                                       category: product.productCategory.name,
                                                       imageUrl: product.productImage.link.href,
                                                       price: product.price.priceDisplay,
                                                       review: product.reviews.reviewDisplay)
                                    }
                                }

                                /** WhatNext
                                 Rather than adding a progress view I would've use a framework called introspect to be able to get more information from the scrollview
                                 and I would then detect when the users are near the bottom, that's when we load more content.

                                 By doing so we can move the progress view outside the LazyVGrid and center it in the view.
                                 */
                                if viewModel.isInitialized && viewModel.canLoadMore {
                                    ProgressView()
                                        .onAppear {
                                            viewModel.loadMore()
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.vertical, 16)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(
                        /** WhatNext
                        Again with the introspect framework we could've detected the direction we are scrolling so this wouldn't be needed
                         */
                        GeometryReader { proxy in
                            Color.clear
                                .preference(key: ViewOffsetKey.self, value: -proxy.frame(in: .named("scroll")).origin.y)
                        }
                    )
                    .onPreferenceChange(ViewOffsetKey.self) {
                        self.scrollDirectionToDisplaySearch(input: $0)
                    }
                }
                .overlay(alignment: .top, content: {
                    HStack {
                        SearchBarView(searchText: $viewModel.searchQuery)
                            .padding(.trailing, 16)

                        OrderByMenuView(orderBy: viewModel.orderBy,
                                           popularityAction: { viewModel.filterSearchResults(type: .Popularity) },
                                           newAction: { viewModel.filterSearchResults(type: .New) },
                                           priceHighAction: { viewModel.filterSearchResults(type: .PriceHigh) },
                                           priceLowAction: { viewModel.filterSearchResults(type: .PriceLow) })
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color("Secondary").opacity(0.5))
                    .opacity(viewModel.shouldDisplaySearch ? 1 : searchBarVisibility)
                })
                .gesture(DragGesture().onChanged({ value in
                    /** What Next
                    Again with the introspect framework we could've detected a pull to refresh and handle it accordingly, this is still acceptable
                     */
                    if value.translation.height > 10 && viewModel.isEmptyOrError {
                        viewModel.reset()
                        viewModel.loadMore()
                    }
                }))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Found \(viewModel.numberOfResults) cards")
            .navigationBarTitleDisplayMode(.large)
            .background(Color("Secondary"))
            .toolbar {
                NavigationToolbarContent()
            }
            .onAppear {
                viewModel.fetchSearchResults()
                viewModel.searchQueryListener()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    private static let searchService = SearchServices()

    static var previews: some View {
        SearchView(searchService: searchService)
    }
}

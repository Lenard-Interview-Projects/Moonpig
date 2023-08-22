//
//  FilterTypeMenuView.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 22/08/2023.
//

import SwiftUI
import MoonpigServices

struct OrderByMenuView: View {
    var orderBy: SearchOrderBy = .Popularity

    var popularityAction: () -> Void = {}
    var newAction: () -> Void = {}
    var priceHighAction: () -> Void = {}
    var priceLowAction: () -> Void = {}

    var body: some View {
        Menu(content: {
            Button { popularityAction() } label: {
                HStack {
                    Text("By Popularity")

                    if orderBy.equal(to: .Popularity) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            Button { newAction() } label: {
                HStack {
                    Text("By New")

                    if orderBy.equal(to: .New) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            Button { priceHighAction() } label: {
                HStack {
                    Text("By Price High ↓")

                    if orderBy.equal(to: .PriceHigh) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            Button { priceLowAction() } label: {
                HStack {
                    Text("By Price Low ↑")

                    if orderBy.equal(to: .PriceLow) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }, label: {
            Image(systemName: "arrow.up.arrow.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(Color("Black"))
        })
    }
}

struct FilterTypeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OrderByMenuView()
    }
}

//
//  SearchItemView.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 21/08/2023.
//

import SwiftUI

struct SearchItemView: View {
    var title: String
    var category: String
    var imageUrl: String
    var price: String
    var review: String

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .padding(16)
                        .frame(width: 150, height: 250, alignment: .center)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                case .failure(_):
                    Image("missing_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay(alignment: .topTrailing) {
                Button { } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("Red"))
                }
                .frame(width: 35, height: 35, alignment: .center)
                .background(Color("Gray").opacity(0.75))
            }

            VStack(alignment: .leading) {
                Text(category)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(Color("Gray"))
                    .lineLimit(2)

                Text(title)
                    .font(.body)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .padding(.vertical, 8)
                    .foregroundColor(Color("Black"))

                HStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("Orange"))

                        Text("\(review)")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundColor(Color("Gray"))
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    Text("\(price)")
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(Color("Green"))

                }

            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color("White"))
    }
}

struct SearchItemView_Previews: PreviewProvider {

    static private var columnGrid = [GridItem(.flexible(), alignment: .top), GridItem(.flexible())]

    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: columnGrid, spacing: 16) {
                SearchItemView(title: "Classic Portrait Personalised Photo Upload Card",
                               category: "Cards",
                               imageUrl: "https://images.unsplash.com/photo-1526512340740s-9217d0159da9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dmVydGljYWx8ZW58MHx8MHx8fDA%3D&w=1000&q=80s",
                               price: "£15.69",
                               review: "4.3 | 1250")
                SearchItemView(title: "Classic Portrait Personalised Photo Upload Card",
                               category: "Cards",
                               imageUrl: "https://moonpig.github.io/tech-test-frontend/image/pu041d/0.jpg",
                               price: "£15.69",
                               review: "4.3 | 1250")
                SearchItemView(title: "Classic Portrait Personalised Photo Upload Card",
                               category: "Cards",
                               imageUrl: "https://images.unsplash.com/photo-1526512340740-9217d0159da9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dmVydGljYWx8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                               price: "£15.69",
                               review: "4.3 | 1250")
                SearchItemView(title: "Classic Portrait Personalised Photo Upload Card",
                               category: "Cards",
                               imageUrl: "https://images.unsplash.com/photo-1526512340740-9217d0159da9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dmVydGljYWx8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                               price: "£15.69",
                               review: "4.3 | 1250")
            }
            .padding(16)
        }
    }
}

//
//  SearchBarView.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 21/08/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("Gray"))

                TextField("Search", text: $searchText)

                .foregroundColor(.primary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color("Gray"), lineWidth: 1)
            )
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Birthday Card"))
    }
}

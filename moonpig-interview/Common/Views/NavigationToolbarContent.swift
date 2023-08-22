//
//  NavigationToolbarContent.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 22/08/2023.
//

import SwiftUI

@ToolbarContentBuilder
func NavigationToolbarContent() -> some ToolbarContent {
    ToolbarItem(placement: .navigationBarLeading) {
        Image("avatar")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30, height: 30)
            .clipShape(Circle())
    }

    ToolbarItem(placement: .navigationBarTrailing) {
        HStack(spacing: 16) {
            Button(action: { /* Open Menu and sort by a few options */ }) {
                Image(systemName: "basket")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("Black"))
            }
        }
    }
}

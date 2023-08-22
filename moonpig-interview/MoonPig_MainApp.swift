//
//  MoonPig_MainApp.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 18/08/2023.
//

import SwiftUI
import MoonpigServices

@main
struct MoonPig_MainApp: App {

    let searchService: SearchServices = SearchServices()

    var body: some Scene {
        WindowGroup {
            SearchView(searchService: searchService)
        }
    }
}

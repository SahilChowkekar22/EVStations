//
//  EVStationsAppApp.swift
//  EVStationsApp
//
//  Created by Sahil ChowKekar on 7/29/25.
//

import SwiftUI

@main
struct EVStationsAppApp: App {
    var body: some Scene {
            WindowGroup {
                StationListView(
                    viewModel: StationListViewModel(
                        service: OpenChargeMapService()
                    )
                )
            }
        }
}

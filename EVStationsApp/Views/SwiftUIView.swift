//
//  SwiftUIView.swift
//  EVStationsApp
//
//  Created by Sahil ChowKekar on 7/29/25.
//

import SwiftUI

struct StationListView: View {
    @ObservedObject var viewModel: StationListViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading stations…")
                } else if let msg = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(msg)")
                        Button("Retry") {
                            viewModel.fetchStations()
                        }
                    }
                } else if viewModel.stations.isEmpty {
                    Text("No stations found.")
                } else {
                    List(viewModel.stations) { station in
                        NavigationLink(
                            destination: StationDetailView(station: station)
                        ) {
                            VStack(alignment: .leading) {
                                Text(station.addressInfo.title)
                                    .font(.headline)
                                Text([
                                    station.addressInfo.addressLine1,
                                    station.addressInfo.town,
                                    station.addressInfo.stateOrProvince
                                ]
                                .compactMap { $0 }
                                .joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("EV Stations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.fetchStations) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}


#Preview {
    StationListView(viewModel: {
        // A mock service that immediately returns a sample station
        struct MockService: OpenChargeMapServiceProtocol {
            func fetchStations(
                latitude: Double,
                longitude: Double,
                completion: @escaping (Result<[EVStation], Error>) -> Void
            ) {
                let sample = EVStation(
                    id: 1,
                    addressInfo: .init(
                        title: "Sample Charger",
                        addressLine1: "100 Electric Ave",
                        town: "ElectriCity",
                        stateOrProvince: "CA",
                        latitude: 37.3349,
                        longitude: -122.0090,
                        accessComments: nil
                    ),
                    connections: [
                        .init(connectionType: .init(title: "CCS Combo"))
                    ]
                )
                completion(.success([sample]))
            }
        }

        let vm = StationListViewModel(service: MockService())
        vm.isLoading = false
        return vm
    }())
}

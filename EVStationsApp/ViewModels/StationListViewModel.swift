//
//  StationListViewModel.swift
//  EVStationsApp
//
//  Created by Sahil ChowKekar on 7/29/25.
//

import Foundation
import CoreLocation

class StationListViewModel: ObservableObject {
    @Published var stations: [EVStation] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: OpenChargeMapServiceProtocol
    private let location: CLLocationCoordinate2D

    init(
        service: OpenChargeMapServiceProtocol,
        location: CLLocationCoordinate2D = CLLocationCoordinate2D(
            latitude: 37.7749, // default: San Francisco
            longitude: -122.4194
        )
    ) {
        self.service = service
        self.location = location
        fetchStations()
    }

    func fetchStations() {
        isLoading = true
        errorMessage = nil

        service.fetchStations(
            latitude: location.latitude,
            longitude: location.longitude
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let list):
                    self?.stations = list
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


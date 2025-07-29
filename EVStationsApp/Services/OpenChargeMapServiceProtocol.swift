//
//  OpenChargeMapServiceProtocol.swift
//  EVStationsApp
//
//  Created by Sahil ChowKekar on 7/29/25.
//

import Foundation

protocol OpenChargeMapServiceProtocol {
    /// Fetches EV stations within ~10 km of given coords.
    func fetchStations(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<[EVStation], Error>) -> Void
    )
}


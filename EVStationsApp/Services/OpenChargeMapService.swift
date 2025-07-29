//
//  OpenChargeMapService.swift
//  EVStationsApp
//
//  Created by Sahil ChowKekar on 7/29/25.
//

import Foundation

class OpenChargeMapService: OpenChargeMapServiceProtocol {
    private let baseURL = "https://api.openchargemap.io/v3/poi/"
    private let apiKey: String? = "e637b933-0215-4def-b525-f34bee5657f9"  // If you have a key, set it here.

    func fetchStations(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<[EVStation], Error>) -> Void
    ) {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "output", value: "json"),
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "distance", value: "10"),
            URLQueryItem(name: "distanceunit", value: "KM")
        ]
        guard let url = components.url else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let key = apiKey {
            request.setValue(key, forHTTPHeaderField: "X-API-Key")
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error)); return
            }
            guard let data = data else {
                completion(.failure(URLError(.zeroByteResource))); return
            }
            do {
                let stations = try JSONDecoder().decode([EVStation].self, from: data)
                completion(.success(stations))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}


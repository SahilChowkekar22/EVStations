//
//  StationDetailView.swift
//  EVStationsApp
//
//  Created by Sahil ChowKekar on 7/29/25.
//

import SwiftUI
import MapKit

struct StationDetailView: View {
    let station: EVStation

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(station.addressInfo.title)
                    .font(.title2)
                    .bold()

                if let address = station.addressInfo.addressLine1 {
                    Text(address)
                }
                if let town = station.addressInfo.town {
                    Text(town)
                }
                if let state = station.addressInfo.stateOrProvince {
                    Text(state)
                }
                if let comments = station.addressInfo.accessComments {
                    Text("Access: \(comments)")
                        .italic()
                }

                if let connections = station.connections, !connections.isEmpty {
                    Text("Connectors:")
                        .font(.headline)
                    ForEach(connections.indices, id: \.self) { i in
                        Text("• \(connections[i].connectionType?.title ?? "Unknown")")
                    }
                }

                Map(
                    coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: station.addressInfo.latitude,
                                longitude: station.addressInfo.longitude
                            ),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    ),
                    annotationItems: [station]
                ) { station in
                    MapMarker(
                        coordinate: CLLocationCoordinate2D(
                            latitude: station.addressInfo.latitude,
                            longitude: station.addressInfo.longitude
                        )
                    )
                }
                .frame(height: 250)
                .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}
#Preview {
    StationDetailView(station: EVStation(
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
    ))
}

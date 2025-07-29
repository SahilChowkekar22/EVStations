//
//  EVStation.swift
//  EVStationsApp
//
//  Created by Sahil ChowKekar on 7/29/25.
//

import Foundation
import CoreLocation

struct EVStation: Decodable, Identifiable {
    let id: Int
    let addressInfo: AddressInfo
    let connections: [Connection]?

    // Map top-level JSON keys → Swift properties
    enum CodingKeys: String, CodingKey {
        case id          = "ID"
        case addressInfo = "AddressInfo"
        case connections = "Connections"
    }

    struct AddressInfo: Decodable {
        let title: String
        let addressLine1: String?
        let town: String?
        let stateOrProvince: String?
        let latitude: Double
        let longitude: Double
        let accessComments: String?

        enum CodingKeys: String, CodingKey {
            case title           = "Title"
            case addressLine1    = "AddressLine1"
            case town            = "Town"
            case stateOrProvince = "StateOrProvince"
            case latitude        = "Latitude"
            case longitude       = "Longitude"
            case accessComments  = "AccessComments"
        }
    }

    struct Connection: Decodable {
        let connectionType: ConnectionType?

        enum CodingKeys: String, CodingKey {
            case connectionType = "ConnectionType"
        }

        struct ConnectionType: Decodable {
            let title: String

            enum CodingKeys: String, CodingKey {
                case title = "Title"
            }
        }
    }
}

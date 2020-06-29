// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let country = try? newJSONDecoder().decode(Country.self, from: jsonData)

import Foundation

// MARK: - CountryElement
struct Country: Codable {
    let currencies: [Currency]
    let languages: [Language]
    let flag: String
    let name, alpha2Code, capital: String
    let population: Int
    let demonym: String
    let area: Double?
    let nativeName: String
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

// MARK: - Language
struct Language: Codable {
    let iso6391: String?
    let iso6392, name, nativeName: String

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

typealias Countries = [Country]


import Foundation

struct StockSymbolApiResponse: Codable {
    let resultSet: ResultSet

    enum CodingKeys: String, CodingKey {
        case resultSet = "ResultSet"
    }
}

struct ResultSet: Codable {
    let query: String
    let result: [Result]

    enum CodingKeys: String, CodingKey {
        case query = "Query"
        case result = "Result"
    }
}

struct Result: Codable {
    let symbol, name, exch, type: String
    let exchDisp, typeDisp: String
}

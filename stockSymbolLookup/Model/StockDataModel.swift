import Foundation

struct ApiResponse: Codable {
    let success: Bool?
    let message: String?
    let results: [StockDataModel]
}

class StockDataModel: NSObject, Codable {
    var id: Int?
    var title: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

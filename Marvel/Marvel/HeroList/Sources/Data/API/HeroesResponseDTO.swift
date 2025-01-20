import Foundation

struct HeroResponseDTOContainer: Codable {
    let code: Int
    let status: String
    let data: HeroDataDTO
}

struct HeroDataDTO: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [HeroResponseDTO]
}

struct HeroResponseDTO: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: ThumbnailDTO
    let resourceURI: String
    let comics: ComicsDTO
}

struct ThumbnailDTO: Codable {
    let path: String
    let `extension`: String
}

struct ComicsDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicItemDTO]
    let returned: Int
}

struct ComicItemDTO: Codable {
    let resourceURI: String
    let name: String
}

extension HeroResponseDTO {
    func toDomain() -> Hero {
        return Hero(
            id: id,
            name: name,
            description: description.isEmpty ? "No description available" : description,
            thumbnailURL: URL(string: "\(thumbnail.path.replacingOccurrences(of: "http://", with: "https://")).\(thumbnail.extension)")!
        )
    }
}

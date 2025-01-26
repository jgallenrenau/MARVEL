import Foundation

public struct HeroResponseDTOContainer: Codable {
    public let code: Int
    public let status: String
    public let data: HeroDataDTO

    public init(code: Int, status: String, data: HeroDataDTO) {
        self.code = code
        self.status = status
        self.data = data
    }
}

public struct HeroDataDTO: Codable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [HeroResponseDTO]

    public init(offset: Int, limit: Int, total: Int, count: Int, results: [HeroResponseDTO]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}

public struct HeroResponseDTO: Codable {
    public let id: Int
    public let name: String
    public let description: String
    public let modified: String
    public let thumbnail: ThumbnailDTO
    public let resourceURI: String
    public let comics: ComicsDTO

    public init(
        id: Int,
        name: String,
        description: String,
        modified: String,
        thumbnail: ThumbnailDTO,
        resourceURI: String,
        comics: ComicsDTO
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
    }
}

public struct ThumbnailDTO: Codable {
    public let path: String
    public let `extension`: String

    public init(path: String, extension: String) {
        self.path = path
        self.extension = `extension`
    }
}

public struct ComicsDTO: Codable {
    public let available: Int
    public let collectionURI: String
    public let items: [ComicItemDTO]
    public let returned: Int

    public init(available: Int, collectionURI: String, items: [ComicItemDTO], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

public struct ComicItemDTO: Codable {
    public let resourceURI: String
    public let name: String

    public init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
}

public extension HeroResponseDTO {
    func toDomain() -> Hero {
        return Hero(
            id: id,
            name: name,
            description: description.isEmpty ? "No description available" : description,
            thumbnailURL: URL(string: "\(thumbnail.path.replacingOccurrences(of: "http://", with: "https://")).\(thumbnail.extension)")!
        )
    }
}

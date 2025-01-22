import Foundation

struct HeroDetailResponseDTOContainer: Codable {
    let code: Int
    let status: String
    let data: HeroDetailDataDTO
}

struct HeroDetailDataDTO: Codable {
    let total: Int
    let count: Int
    let results: [HeroDetailResponseDTO]
}

struct HeroDetailResponseDTO: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: ThumbnailDTO
    let resourceURI: String
    let comics: ComicsDTO
    let series: SeriesDTO
    let stories: StoriesDTO
    let events: EventsDTO
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

struct SeriesDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [SeriesItemDTO]
    let returned: Int
}

struct SeriesItemDTO: Codable {
    let resourceURI: String
    let name: String
}

struct StoriesDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoryItemDTO]
    let returned: Int
}

struct StoryItemDTO: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

struct EventsDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [EventItemDTO]
    let returned: Int
}

struct EventItemDTO: Codable {
    let resourceURI: String
    let name: String
}

extension HeroDetailResponseDTO {
    func toDomain() -> HeroDetail {
        return HeroDetail(
            id: id,
            name: name,
            description: description.isEmpty ? "No description available" : description,
            thumbnailURL: URL(string: "\(thumbnail.path.replacingOccurrences(of: "http://", with: "https://")).\(thumbnail.extension)")!,
            comics: comics.items.map { $0.name },
            series: series.items.map { $0.name },
            stories: stories.items.map { $0.name },
            events: events.items.map { $0.name }
        )
    }
}

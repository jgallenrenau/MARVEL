import Foundation

struct HeroDetail: Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnailURL: URL
    let comics: [String]
    let series: [String]
    let stories: [String]
    let events: [String]
}

struct Comic: Equatable {
    let name: String
}

struct Series: Equatable {
    let name: String
}

struct Story: Equatable {
    let name: String
    let type: String
}

struct Event: Equatable {
    let name: String
}

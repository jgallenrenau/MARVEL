import Foundation

public struct Hero: Identifiable, Equatable {
    public let id: Int
    let name: String
    let description: String
    let thumbnailURL: URL
}

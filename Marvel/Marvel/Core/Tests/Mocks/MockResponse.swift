import Foundation

struct MockResponse: Decodable {
    let data: MockData
}

struct MockData: Decodable {
    let results: [MockResult]
}

struct MockResult: Decodable {
    let id: Int
    let name: String
}

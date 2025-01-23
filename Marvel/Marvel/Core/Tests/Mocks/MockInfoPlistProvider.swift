import Foundation
@testable import Core

class MockInfoPlistProvider: InfoPlistProvider {
    private var mockValues: [String: String]
    
    init(mockValues: [String: String]) {
        self.mockValues = mockValues
    }
    
    func value(forKey key: String) -> String? {
        return mockValues[key]
    }
}

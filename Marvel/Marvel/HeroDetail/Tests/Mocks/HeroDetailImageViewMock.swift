import XCTest
import SwiftUI
import Core
@testable import HeroDetail

struct HeroDetailImageViewMock: View {
    enum State {
        case empty
        case success(Image)
        case failure
    }

    let state: State

    var body: some View {
        Group {
            switch state {
            case .empty:
                HeroDetailImageView(imageURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)
                    .task {}
            case .success(let image):
                HeroDetailImageViewMockSuccessView(image: image)
            case .failure:
                HeroDetailImageViewMockFailureView()
            }
        }
    }
}

struct HeroDetailImageViewMockSuccessView: View {
    let image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 400, height: 400)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}

struct HeroDetailImageViewMockFailureView: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: 400, height: 400)
            .foregroundColor(.gray)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

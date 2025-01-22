import SwiftUI

struct HeroDetailImageView: View {
    let imageURL: URL

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 400, height: 400)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
            @unknown default:
                EmptyView()
            }
        }
    }
}
//
//#Preview {
//    HeroDetailImageView(
//        imageURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!
//    )
//}

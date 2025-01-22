import SwiftUI

struct HeroesRowView: View {
    let hero: Hero

    var body: some View {
        HStack {
            AsyncImage(url: hero.thumbnailURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(hero.name).font(.headline)
                Text(hero.description).font(.subheadline).lineLimit(2)
            }
        }
        .padding()
    }
}

//#Preview {
//    HeroesRowView(hero: Hero(id: 0, name: "Capitan america", description: "The best one", thumbnailURL: URL(fileURLWithPath: "")))
//}
  

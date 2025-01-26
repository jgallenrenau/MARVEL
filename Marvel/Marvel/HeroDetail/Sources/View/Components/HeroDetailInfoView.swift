import SwiftUI

struct HeroDetailInfoView: View {
    let name: String
    let description: String
    let comics: [String]
    let series: [String]
    let stories: [String]
    let events: [String]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text(description.isEmpty ? "No description available." : description)
                    .font(.body)
                    .foregroundColor(.secondary)

                if !comics.isEmpty {
                    SectionView(title: "Comics", items: comics)
                }

                if !series.isEmpty {
                    SectionView(title: "Series", items: series)
                }

                if !stories.isEmpty {
                    SectionView(title: "Stories", items: stories)
                }

                if !events.isEmpty {
                    SectionView(title: "Events", items: events)
                }
            }
            .padding()
        }
    }
}

struct SectionView: View {
    let title: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 4)

            ForEach(items, id: \.self) { item in
                Text("• \(item)")
                    .font(.body)
            }
        }
    }
}

#Preview {
    HeroDetailInfoView(
        name: "Spider-Man",
        description: "A friendly neighborhood superhero.",
        comics: ["Comic 1", "Comic 2"],
        series: ["Series 1", "Series 2"],
        stories: ["Story 1", "Story 2"],
        events: ["Event 1", "Event 2"]
    )
}

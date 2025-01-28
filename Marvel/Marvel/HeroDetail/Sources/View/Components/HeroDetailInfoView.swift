import SwiftUI
import DesignSystem

struct HeroDetailInfoView: View {
    let name: String
    let description: String
    let comics: [String]
    let series: [String]
    let stories: [String]
    let events: [String]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DSPadding.normal) {
                Text(name)
                    .font(DSFonts.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text(description.isEmpty ? "No description available." : description)
                    .font(DSFonts.body)
                    .foregroundColor(DSColors.secondaryText)

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
            .padding(DSPadding.normal)
        }
    }
}

struct SectionView: View {
    let title: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: DSPadding.small) {
            Text(title)
                .font(DSFonts.headline)
                .padding(.bottom, DSPadding.xSmall)
                .foregroundColor(DSColors.gray)

            ForEach(items, id: \.self) { item in
                Text("• \(item)")
                    .font(DSFonts.body)
                    .foregroundColor(DSColors.gray)
            }
        }
    }
}

// MARK: - Preview
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


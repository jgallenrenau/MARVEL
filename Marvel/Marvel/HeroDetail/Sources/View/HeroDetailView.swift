import SwiftUI
import ComposableArchitecture

struct HeroDetailView: View {
    let store: StoreOf<HeroDetailFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                
                if viewStore.isLoading {
                    CenteredSpinnerView(isLoading: viewStore.isLoading)
                } else if let hero = viewStore.hero {
                    ScrollView {
                        VStack(spacing: 24) {
                            ListHeaderView(key: "heroDetail_title", bundle: .heroList)

                            HeroDetailImageView(imageURL: hero.thumbnailURL)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                                .padding(.top, 16)

                            VStack(alignment: .leading, spacing: 16) {
                                Text(hero.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)

                                if !hero.description.isEmpty {
                                    Text(hero.description)
                                        .font(.body)
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.horizontal)
                                }

                                Divider()
                                    .background(Color.white.opacity(0.6))
                                    .padding(.horizontal)

                                SectionHeaderView(localizedKey: "heroDetail_comics", bundle: .heroList)
                                ForEach(hero.comics, id: \.self) { comic in
                                    Text("• \(comic)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 4)
                                }

                                SectionHeaderView(localizedKey: "heroDetail_series", bundle: .heroList)
                                ForEach(hero.series, id: \.self) { series in
                                    Text("• \(series)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }

                                SectionHeaderView(localizedKey: "heroDetail_stories", bundle: .heroList)
                                ForEach(hero.stories, id: \.self) { story in
                                    Text("• \(story)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }

                                SectionHeaderView(localizedKey: "heroDetail_events", bundle: .heroList)
                                ForEach(hero.events, id: \.self) { event in
                                    Text("• \(event)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black.opacity(0.4))
                            )
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                        }
                    }
                } else if let errorMessage = viewStore.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .animation(.easeInOut, value: viewStore.isLoading)
            .onAppear {
                viewStore.send(.fetchHeroDetail)
            }
        }
    }
}


struct SectionHeaderView: View {
    let localizedKey: String
    let bundle: Bundle

    var body: some View {
        Text(localizedKey.localized(bundle: bundle))
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.top, 16)
    }
}

struct CenteredSpinnerView: View {
    let isLoading: Bool

    var body: some View {
        if isLoading {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground).opacity(0.8))
                )
                .shadow(radius: 10)
        }
    }
}

//#Preview {
//    HeroDetailView(
//        store: Store(
//            initialState: HeroDetailFeature.State(
//                hero: HeroDetail(
//                    id: 1,
//                    name: "Spider-Man",
//                    description: "A friendly neighborhood superhero.",
//                    thumbnailURL: URL(string: "https://example.com/image.jpg"),
//                    comics: ["Comic 1", "Comic 2"],
//                    series: ["Series 1", "Series 2"],
//                    stories: ["Story 1", "Story 2"],
//                    events: ["Event 1", "Event 2"]
//                )
//            ),
//            reducer: HeroDetailFeature()
//        )
//    )
//}

func ListHeaderView(key: String, bundle: Bundle) -> some View {
    Text(key.localized(bundle: bundle))
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color(.clear))
}

public extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: self, comment: "")
    }
}

public extension Bundle {
    static var heroList: Bundle {
        return Bundle.module
    }
}

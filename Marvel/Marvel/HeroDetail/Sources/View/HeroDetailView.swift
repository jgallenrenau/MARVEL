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
                        VStack(spacing: 16) {
                            ListHeaderView(key: "heroDetail_title", bundle: .heroList)
                                .padding(.bottom, 16)

                            HeroDetailImageView(imageURL: hero.thumbnailURL)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)

                            VStack(alignment: .leading, spacing: 32) {

                                VStack(alignment: .leading, spacing: 8) {
                                    SectionHeaderView(localizedKey: "heroDetail_comics", bundle: .heroList)
                                    ForEach(hero.comics, id: \.self) { comic in
                                        Text("• \(comic)")
                                            .font(.callout)
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                            .padding(.vertical, 4)
                                    }
                                }
                                .background(Color.clear)

                                VStack(alignment: .leading, spacing: 8) {
                                    SectionHeaderView(localizedKey: "heroDetail_series", bundle: .heroList)
                                    ForEach(hero.series, id: \.self) { series in
                                        Text("• \(series)")
                                            .font(.callout)
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                            .padding(.vertical, 4)
                                    }
                                }
                                .background(Color.clear)

                                VStack(alignment: .leading, spacing: 8) {
                                    SectionHeaderView(localizedKey: "heroDetail_stories", bundle: .heroList)
                                    ForEach(hero.stories, id: \.self) { story in
                                        Text("• \(story)")
                                            .font(.callout)
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                            .padding(.vertical, 4)
                                    }
                                }
                                .background(Color.clear)

                                VStack(alignment: .leading, spacing: 8) {
                                    SectionHeaderView(localizedKey: "heroDetail_events", bundle: .heroList)
                                    ForEach(hero.events, id: \.self) { event in
                                        Text("• \(event)")
                                            .font(.callout)
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                            .padding(.vertical, 4)
                                    }
                                }
                                .background(Color.clear)
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

func ListHeaderView(key: String, bundle: Bundle) -> some View {
    Text(key.localized(bundle: bundle))
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .center)
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

#Preview {
    HeroDetailView(
        store: Store(
            initialState: HeroDetailFeature.State(
                heroId: 1,
                hero: HeroDetail(
                    id: 1,
                    name: "3-D Man",
                    description: "No description available",
                    thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
                    comics: ["Comic 1", "Comic 2", "Comic 3"],
                    series: ["Series 1", "Series 2"],
                    stories: ["Story 1", "Story 2"],
                    events: ["Event 1", "Event 2"]
                )
            ),
            reducer: { HeroDetailFeature() }
        )
    )
    .previewLayout(.sizeThatFits)
}


import SwiftUI
import ComposableArchitecture

struct HeroDetailView: View {
    let store: StoreOf<HeroDetailFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                if viewStore.isLoading {
                    CenteredSpinnerView(isLoading: viewStore.isLoading)
                } else if let hero = viewStore.hero {
                    ScrollView {
                        VStack(spacing: 16) {
                            HeroDetailImageView(imageURL: hero.thumbnailURL)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                                .padding(.top, 16)

                            VStack(alignment: .leading, spacing: 8) {
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

                                SectionHeaderView(title: "Comics")
                                ForEach(hero.comics, id: \.self) { comic in
                                    Text("• \(comic)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }

                                SectionHeaderView(title: "Series")
                                ForEach(hero.series, id: \.self) { series in
                                    Text("• \(series)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }
                                
                                SectionHeaderView(title: "Stories")
                                ForEach(hero.series, id: \.self) { series in
                                    Text("• \(series)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }
                                
                                SectionHeaderView(title: "Events")
                                ForEach(hero.series, id: \.self) { series in
                                    Text("• \(series)")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }
                                .padding()
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black.opacity(0.4))
                            )
                            .padding()
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
    let title: String

    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.top, 8)
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

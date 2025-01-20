import SwiftUI
import ComposableArchitecture

struct HeroesListView: View {
    let store: StoreOf<HeroesListFeature>
    let onHeroSelected: (Hero) -> Void

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                List {
                    ForEach(viewStore.heroes) { hero in
                        HeroesRowView(hero: hero)
                            .onAppear {
                                if let index = viewStore.heroes.firstIndex(of: hero),
                                   index >= viewStore.heroes.count - HeroesListFeature.Config.thresholdForLoadingMore {
                                    viewStore.send(.loadMoreHeroes)
                                }
                            }
                            .onTapGesture {
                                onHeroSelected(hero)
                            }
                    }
                }
                .onAppear {
                    viewStore.send(.fetchHeroes)
                }

                CenteredSpinnerView(isLoading: viewStore.isLoading)
            }
        }
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

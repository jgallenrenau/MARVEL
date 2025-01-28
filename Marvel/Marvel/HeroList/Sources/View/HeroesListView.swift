import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

struct HeroesListView: View {
    let store: StoreOf<HeroesListFeature>
    let onHeroSelected: (Hero) -> Void

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: DSPadding.small) {
                headerView(viewStore: viewStore)
                contentView(viewStore: viewStore)
            }
            .background(DSColors.background)
        }
    }

    // MARK: - Header
    private func headerView(viewStore: ViewStore<HeroesListFeature.State, HeroesListFeature.Action>) -> some View {
        VStack(spacing: DSPadding.xSmall) {
            DSHeaderView(key: "heroesList_title".localized(), bundle: .heroList)

            DSSearchBar(
                text: viewStore.binding(
                    get: \.searchText,
                    send: HeroesListFeature.Action.searchTextChanged
                ),
                placeholder: "heroesList_search_placeholder".localized(),
                bundle: .heroList,
                icon: "magnifyingglass",
                clearIcon: "xmark.circle.fill"
            )
        }
        .padding(DSPadding.normal)
        .background(DSColors.background)
    }

    // MARK: - Content View
    private func contentView(viewStore: ViewStore<HeroesListFeature.State, HeroesListFeature.Action>) -> some View {
        if viewStore.isLoading && viewStore.heroes.isEmpty {
            return AnyView(loadingView)
        } else if viewStore.filteredHeroes.isEmpty && !viewStore.searchText.isEmpty {
            return AnyView(noResultsView)
        } else {
            return AnyView(heroesListView(viewStore: viewStore))
        }
    }

    // MARK: - Loading View
    private var loadingView: some View {
        DSCenteredSpinnerView(isLoading: true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DSColors.background)
    }

    // MARK: - No Results View
    private var noResultsView: some View {
        DSNoResultsView(
            imageName: "magnifyingglass.circle",
            title: "noResultsView_title".localized(bundle: .heroList),
            message: "noResultsView_message".localized(bundle: .heroList)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DSColors.background)
    }

    // MARK: - Heroes List View
    private func heroesListView(viewStore: ViewStore<HeroesListFeature.State, HeroesListFeature.Action>) -> some View {
        ZStack {
            List {
                ForEach(viewStore.filteredHeroes, id: \.id) { hero in
                    HeroesRowView(hero: hero)
                        .onAppear {
                            handlePagination(for: hero, in: viewStore)
                        }
                        .onTapGesture {
                            onHeroSelected(hero)
                        }
                }

                if viewStore.isLoading {
                    listLoadingIndicator
                }
            }
            .listStyle(PlainListStyle())

            if viewStore.isLoading {
                DSCenteredSpinnerView(isLoading: viewStore.isLoading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            viewStore.send(.fetchHeroes)
        }
    }

    // MARK: - List Loading Indicator
    private var listLoadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
                .padding(DSPadding.normal)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Pagination Handling
    private func handlePagination(for hero: Hero, in viewStore: ViewStore<HeroesListFeature.State, HeroesListFeature.Action>) {
        if let index = viewStore.heroes.firstIndex(where: { $0.id == hero.id }),
           index >= viewStore.heroes.count - Constants.PaginationConfig.thresholdForLoadingMore {
            viewStore.send(.loadMoreHeroes)
        }
    }
}

// MARK: - Extensions

public extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: self, comment: "")
    }
}

public extension Bundle {
    static var heroList: Bundle {
        return .module
    }
}

// MARK: - Preview
#Preview {
    HeroesListView(
        store: Store(
            initialState: HeroesListFeature.State(
                heroes: [
                    Hero(
                        id: 1,
                        name: "Spider-Man",
                        description: "A superhero with spider-like abilities.",
                        thumbnailURL: URL(string: "https://via.placeholder.com/150")!
                    ),
                    Hero(
                        id: 2,
                        name: "Iron Man",
                        description: "A genius inventor in a high-tech suit.",
                        thumbnailURL: URL(string: "https://via.placeholder.com/150")!
                    )
                ],
                filteredHeroes: [
                    Hero(
                        id: 1,
                        name: "Spider-Man",
                        description: "A superhero with spider-like abilities.",
                        thumbnailURL: URL(string: "https://via.placeholder.com/150")!
                    )
                ],
                searchText: "",
                isLoading: false
            ),
            reducer: { HeroesListFeature() }
        ),
        onHeroSelected: { hero in
            print("Selected hero: \(hero.name)")
        }
    )
    .previewLayout(.sizeThatFits)
    .padding(DSPadding.normal)
    .background(DSColors.gray.opacity(DSOpacity.xSmall))
}

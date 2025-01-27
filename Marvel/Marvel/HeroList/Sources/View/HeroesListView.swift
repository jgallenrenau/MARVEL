import SwiftUI
import Core
import ComposableArchitecture

struct HeroesListView: View {
    let store: StoreOf<HeroesListFeature>
    let onHeroSelected: (Hero) -> Void

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                VStack(spacing: 10) {
                    ListHeaderView(key: "heroesList_title", bundle: .heroList)
                    
                    SearchBar(
                        text: viewStore.binding(
                            get: \.searchText,
                            send: HeroesListFeature.Action.searchTextChanged
                        )
                    )
                    .padding(.horizontal)
                }
                .background(Color(UIColor.systemBackground))
                
                if viewStore.isLoading && viewStore.heroes.isEmpty {

                    CenteredSpinnerView(isLoading: viewStore.isLoading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewStore.filteredHeroes.isEmpty && !viewStore.searchText.isEmpty {

                    EmptyStateView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ZStack {
                        List {
                            ForEach(viewStore.filteredHeroes, id: \.id) { hero in
                                HeroesRowView(hero: hero)
                                    .onAppear {
                                        if let index = viewStore.heroes.firstIndex(where: { $0.id == hero.id }),
                                           index >= viewStore.heroes.count - Constants.PaginationConfig.thresholdForLoadingMore {
                                            viewStore.send(.loadMoreHeroes)
                                        }
                                    }
                                    .onTapGesture {
                                        onHeroSelected(hero)
                                    }
                            }

                            if viewStore.isLoading {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .padding()
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }

                        if viewStore.isLoading {
                            CenteredSpinnerView(isLoading: viewStore.isLoading)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .onAppear {
                        viewStore.send(.fetchHeroes)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(isFocused ? .gray : .secondary)
            
            TextField("Search for heroes...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(.primary)
                .accentColor(.gray)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .focused($isFocused)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .transition(.scale)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemGray6))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
        .animation(.easeInOut(duration: 0.2), value: text)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
            
            Text("No heroes found")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Try searching with a different keyword.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

func ListHeaderView(key: String, bundle: Bundle) -> some View {
    Text(key.localized(bundle: bundle))
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
        .background(Color(UIColor.systemGray6))
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

struct TitleHeaderView: View {
    var body: some View {
        Text("heroesList_title".localized(bundle: .heroList))
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            .background(Color(.clear))
    }
}

public extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: self, comment: "")
    }
}

public extension Bundle {
    static var heroList: Bundle {
        return .module
    }
    
    static var heroDetail: Bundle {
        return .module
    }
}

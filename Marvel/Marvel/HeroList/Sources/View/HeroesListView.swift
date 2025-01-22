import SwiftUI
import ComposableArchitecture

struct HeroesListView: View {
    let store: StoreOf<HeroesListFeature>
    let onHeroSelected: (Hero) -> Void

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 10) {
                
                ListHeaderView(key: "heroesList_title", bundle: .heroList)
                
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
}

func ListHeaderView(key: String, bundle: Bundle) -> some View {
    Text(key.localized(bundle: bundle))
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
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

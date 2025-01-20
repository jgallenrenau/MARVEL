import SwiftUI
import ComposableArchitecture

public struct HeroListCoordinator: View {
    let onHeroSelected: (Hero) -> Void

    public init(onHeroSelected: @escaping (Hero) -> Void) {
        self.onHeroSelected = onHeroSelected
    }

    public var body: some View {
        HeroesListView(
            store: Store(
                initialState: HeroesListFeature.State(),
                reducer: {
                    HeroesListFeature()
                }
            ),
            onHeroSelected: onHeroSelected
        )
    }
}

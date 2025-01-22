import SwiftUI
import ComposableArchitecture

public struct HeroDetailCoordinator: View {
    public let heroId: Int
    
    public init(heroId: Int) {
        self.heroId = heroId
    }

    public var body: some View {
        HeroDetailView(
            store: Store(
                initialState: HeroDetailFeature.State(heroId: heroId),
                reducer: {
                    HeroDetailFeature()
                }
            )
        )
    }
}

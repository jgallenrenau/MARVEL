import SwiftUI
import HeroList
//import HeroDetail

@main
struct MarvelApp: App {
    @State private var selectedHero: Hero?

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HeroListCoordinator(
                    onHeroSelected: { hero in
                        self.selectedHero = hero
                    }
                )
                .navigationTitle("Heroes")
                .sheet(item: $selectedHero) { hero in
                    // TODO: HeroDetailCoordinator(hero: hero)
                }
            }
            .onAppear {
                AppInitializer.initializeKeys()
            }
        }
    }
}

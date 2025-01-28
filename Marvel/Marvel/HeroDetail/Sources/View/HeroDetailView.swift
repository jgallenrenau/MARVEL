import SwiftUI
import ComposableArchitecture
import DesignSystem

struct HeroDetailView: View {
    let store: StoreOf<HeroDetailFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                DSColors.background.ignoresSafeArea()

                if viewStore.isLoading {
                    loadingView
                } else if let hero = viewStore.hero {
                    heroDetailContent(hero: hero)
                } else if let errorMessage = viewStore.errorMessage {
                    errorView(message: errorMessage)
                }
            }
            .animation(.easeInOut(duration: DSTimeAnimation.normal), value: viewStore.isLoading)
            .onAppear { viewStore.send(.fetchHeroDetail) }
        }
    }

    // MARK: - Loading View
    private var loadingView: some View {
        DSCenteredSpinnerView(isLoading: true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Error View
    private func errorView(message: String) -> some View {
        Text(message)
            .foregroundColor(DSColors.errorText)
            .multilineTextAlignment(.center)
            .padding(DSPadding.normal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Hero Detail Content
    private func heroDetailContent(hero: HeroDetail) -> some View {
        ScrollView {
            VStack(spacing: DSPadding.large) {
                heroImageView(hero: hero)
                heroInfoView(hero: hero)
                HeroDetailSectionsView(hero: hero)
            }
            .padding(.horizontal, DSPadding.normal)
        }
    }

    // MARK: - Hero Image View
    private func heroImageView(hero: HeroDetail) -> some View {
        HeroDetailImageView(imageURL: hero.thumbnailURL)
            .clipShape(RoundedRectangle(cornerRadius: DSCorner.xLarge))
            .overlay(
                RoundedRectangle(cornerRadius: DSCorner.xLarge)
                    .stroke(DSColors.white.opacity(DSOpacity.dotSix), lineWidth: 2)
            )
            .shadow(color: DSShadows.medium, radius: DSImage.imageShadowRadius, x: 0, y: 2)
            .padding(.horizontal, DSPadding.large)
            .padding(.top, DSPadding.large)
    }

    // MARK: - Hero Info View
    private func heroInfoView(hero: HeroDetail) -> some View {
        VStack(spacing: DSPadding.small) {
            Text(hero.name)
                .font(DSFonts.title)
                .fontWeight(.bold)
                .foregroundColor(DSColors.primaryText)
                .multilineTextAlignment(.center)

            Text(hero.description.isEmpty ? "" : hero.description)
                .font(DSFonts.body)
                .foregroundColor(DSColors.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, DSPadding.large)
        }
    }
}

// MARK: - Preview
#Preview {
    HeroDetailView(
        store: Store(
            initialState: HeroDetailFeature.State(
                heroId: 1,
                hero: HeroDetail(
                    id: 1,
                    name: "Spider-Man",
                    description: "A friendly neighborhood superhero.",
                    thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
                    comics: ["Amazing Spider-Man #1", "Ultimate Spider-Man #2"],
                    series: ["Marvel's Spider-Man", "Ultimate Comics"],
                    stories: ["Spider-Verse", "The Clone Saga"],
                    events: ["Civil War", "Secret Wars"]
                ),
                isLoading: false
            ),
            reducer: { HeroDetailFeature() }
        )
    )
    .previewLayout(.sizeThatFits)
    .padding(DSPadding.normal)
    .background(DSColors.black.opacity(DSOpacity.dotFour))
}

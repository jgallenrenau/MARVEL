import SwiftUI
import DesignSystem

struct HeroesRowView: View {
    let hero: Hero

    var body: some View {
        HStack(spacing: DSPadding.normal) {
            heroImageView
            heroInfoView
            Spacer()
        }
        .padding(DSPadding.normal)
        .background(
            RoundedRectangle(cornerRadius: DSCorner.large)
                .fill(DSColors.background)
                .shadow(color: DSShadows.small, radius: DSImage.imageShadowRadius, x: 0, y: 2)
        )
        .padding(.horizontal, DSPadding.normal)
    }

    // MARK: - Hero Image
    private var heroImageView: some View {
        AsyncImage(url: hero.thumbnailURL) { phase in
            switch phase {
            case .empty:
                placeholderView
            case .success(let image):
                imageView(image)
            case .failure:
                errorView
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: DSImage.defaultSize / 4, height: DSImage.defaultSize / 4)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(DSColors.white.opacity(0.8), lineWidth: 2)
        )
        .shadow(color: DSShadows.medium, radius: DSImage.imageShadowRadius, x: 0, y: 2)
    }

    // MARK: - Placeholder View
    private var placeholderView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DSImage.placeholderBackground)
    }

    // MARK: - Image View
    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
    }

    // MARK: - Error View
    private var errorView: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(DSImage.errorIconColor)
            .background(DSImage.placeholderBackground)
    }

    // MARK: - Hero Info
    private var heroInfoView: some View {
        VStack(alignment: .leading, spacing: DSPadding.xSmall) {
            Text(hero.name)
                .font(DSFonts.subtitle)
                .fontWeight(.bold)
                .foregroundColor(DSColors.primaryText)

            Text(hero.description.isEmpty ? "No description available." : hero.description)
                .font(DSFonts.subheadline)
                .foregroundColor(DSColors.secondaryText)
                .lineLimit(2)
        }
    }
}

// MARK: - Preview
#Preview {
    VStack {
        HeroesRowView(hero: Hero(id: 0, name: "Spider-Man", description: "A friendly neighborhood superhero.", thumbnailURL: URL(string: "https://via.placeholder.com/150")!))
        HeroesRowView(hero: Hero(id: 1, name: "Iron Man", description: "A genius inventor in a high-tech suit.", thumbnailURL: URL(string: "https://via.placeholder.com/150")!))
    }
    .previewLayout(.sizeThatFits)
    .padding(DSPadding.normal)
    .background(DSColors.gray.opacity(DSOpacity.xSmall))
}

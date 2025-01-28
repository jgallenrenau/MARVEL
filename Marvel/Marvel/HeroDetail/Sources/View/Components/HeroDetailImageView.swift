import SwiftUI
import DesignSystem

struct HeroDetailImageView: View {
    let imageURL: URL
    @StateObject private var motionManager = DSParallaxMotionManager()

    var body: some View {
        AsyncImage(url: imageURL) { phase in
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
        .frame(width: DSImage.defaultSize, height: DSImage.defaultSize)
        .clipShape(RoundedRectangle(cornerRadius: DSImage.imageCornerRadius))
        .shadow(radius: DSImage.imageShadowRadius)
        .offset(x: motionManager.xOffset, y: motionManager.yOffset)
        .animation(.easeInOut(duration: 0.2), value: motionManager.xOffset)
    }

    private var placeholderView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DSImage.placeholderBackground)
    }

    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var errorView: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(DSImage.errorIconColor)
            .background(DSImage.placeholderBackground)
    }
}

// MARK: - Preview
#Preview {
    HeroDetailImageView(
        imageURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!
    )
    .previewLayout(.sizeThatFits)
    .padding(DSPadding.normal)
    .background(DSColors.gray.opacity(DSOpacity.dotOne))
}

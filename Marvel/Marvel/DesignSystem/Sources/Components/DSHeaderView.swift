import SwiftUI

public func DSHeaderView(imageName: String? = nil, key: String? = nil, bundle: Bundle) -> some View {
    HStack {
        if let imageName = imageName {
            Image(imageName)
                .resizable()
                .scaledToFit()
        } else if let key = key {
            Text(key.localized(bundle: bundle))
                .font(DSFonts.title)
                .fontWeight(.semibold)
                .foregroundColor(DSColors.primaryText)
        }
    }
    .padding(.horizontal, DSPadding.normal)
    .padding(.vertical, DSPadding.xSmall)
    .background(Color.clear)
}

#Preview {
    VStack {
        DSHeaderView(imageName: "marvel_transparent", bundle: .main)
        DSHeaderView(key: "header_title".localized(), bundle: .main)
    }
    .previewLayout(.sizeThatFits)
    .padding(DSPadding.normal)
    .background(DSColors.gray.opacity(DSOpacity.dotTwo))
}

import SwiftUI

public func DSHeaderView(key: String, bundle: Bundle) -> some View {
    HStack {
        Text(key.localized(bundle: bundle))
            .font(DSFonts.subtitle)
            .fontWeight(.semibold)
            .foregroundColor(DSColors.primaryText)
    }
    .padding(.horizontal, DSPadding.normal)
    .padding(.vertical, DSPadding.xSmall)
    .background(Color.clear)
}

#Preview {
    DSHeaderView(key: "header_title".localized(), bundle: .main)
        .previewLayout(.sizeThatFits)
        .padding(DSPadding.normal)
        .background(DSColors.gray.opacity(DSOpacity.small))
}

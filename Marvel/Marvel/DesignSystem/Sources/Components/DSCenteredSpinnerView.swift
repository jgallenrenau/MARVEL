import SwiftUI

public func DSCenteredSpinnerView(isLoading: Bool) -> some View {
    Group {
        if isLoading {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: DSCorner.medium)
                        .fill(DSColors.background.opacity(DSOpacity.dotEight))
                )
                .shadow(color: DSShadows.medium, radius: DSCorner.medium)
        }
    }
}

#Preview {
    VStack {
        DSCenteredSpinnerView(isLoading: true)
            .previewLayout(.sizeThatFits)
            .padding(DSPadding.normal)
            .background(DSColors.gray.opacity(DSOpacity.dotOne))
    }
}

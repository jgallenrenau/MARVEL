import SwiftUI

public struct DSSectionHeaderView: View {
    public let localizedKey: String
    public let bundle: Bundle

    public init(localizedKey: String, bundle: Bundle) {
        self.localizedKey = localizedKey
        self.bundle = bundle
    }

    public var body: some View {
        Text(localizedKey.localized(bundle: bundle))
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.top, DSPadding.normal)
    }
}

#Preview {
    DSSectionHeaderView(
        localizedKey: "section_title",
        bundle: .main
    )
    .previewLayout(.sizeThatFits)
    .padding()
    .background(Color.black)
}

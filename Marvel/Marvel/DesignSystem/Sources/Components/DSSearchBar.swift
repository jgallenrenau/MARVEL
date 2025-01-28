import SwiftUI

public struct DSSearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var placeholder: String
    var bundle: Bundle
    var icon: String
    var clearIcon: String

    public init(
        text: Binding<String>,
        placeholder: String = "searchBar_placeholder".localized(),
        bundle: Bundle,
        icon: String = "magnifyingglass",
        clearIcon: String = "xmark.circle.fill"
    ) {
        self._text = text
        self.placeholder = "Search for heroes..."
        self.bundle = bundle
        self.icon = icon
        self.clearIcon = clearIcon
    }

    public var body: some View {
        HStack {
            Image(systemName: icon.localized(bundle: bundle))
                .foregroundColor(isFocused ? DSColors.gray : DSColors.secondaryText)

            TextField(placeholder.localized(bundle: bundle), text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(DSColors.primaryText)
                .accentColor(DSColors.gray)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .focused($isFocused)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: clearIcon)
                        .foregroundColor(DSColors.secondaryText)
                }
                .transition(.scale)
            }
        }
        .padding(DSPadding.small)
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: DSCorner.large)
                .fill(DSColors.searchBarBackground)
                .shadow(color: DSShadows.small, radius: DSCorner.xSmall, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: DSCorner.large)
                .stroke(DSColors.gray.opacity(DSOpacity.dotFour), lineWidth: 2)
        )

        .padding(.horizontal, DSPadding.normal)
        .animation(.easeInOut(duration: DSTimeAnimation.fast), value: text)
    }
}

public extension String {
    func localized(bundle: Bundle = .main) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: self, comment: "")
    }
}

#Preview {
    @State var searchText: String = ""

    return DSSearchBar(
        text: $searchText,
        placeholder: "Search...",
        bundle: .main,
        icon: "magnifyingglass",
        clearIcon: "xmark.circle.fill"
    )
    .previewLayout(.sizeThatFits)
    .padding(DSPadding.normal)
    .background(DSColors.gray.opacity(DSOpacity.dotTwo))
}

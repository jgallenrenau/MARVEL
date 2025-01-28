import SwiftUI

public func DSNoResultsView(imageName: String,
                            title: String,
                            message: String) -> some View {
    VStack {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .foregroundColor(.gray)
            .padding(.bottom, DSPadding.normal)
        
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
        
        Text(message)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    .padding()
}

#Preview {
    DSNoResultsView(
        imageName: "magnifyingglass.circle",
        title: "No results found",
        message: "Try adjusting your search criteria."
    )
    .previewLayout(.sizeThatFits)
    .padding()
    .background(Color.gray.opacity(DSOpacity.dotTwo))
}

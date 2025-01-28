import SwiftUI
import DesignSystem

struct SplashScreenView: View {
    
    var onAnimationEnd: () -> Void
    
    @State private var scaleEffect = 0.0
    @State private var opacity = DSOpacity.zero

    var body: some View {
        ZStack {
            backgroundView()
            contentView()
        }
        .onAppear {
            startAnimations()
            navigateAfterDelay()
        }
    }
    
    // MARK: - Background View
    @ViewBuilder
    private func backgroundView() -> some View {
        DSColors.backgroundRed
            .edgesIgnoringSafeArea(.all)
    }
    
    // MARK: - Content View
    @ViewBuilder
    private func contentView() -> some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                animatedLogo(maxWidth: geometry.size.width)
                Spacer()
            }
        }
    }
    
    // MARK: - Animated Logo
    @ViewBuilder
    private func animatedLogo(maxWidth: CGFloat) -> some View {
        Image("marvel_logo")
            .resizable()
            .scaledToFit()
            .frame(width: maxWidth)
            .scaleEffect(scaleEffect)
            .opacity(opacity)
    }
    
    // MARK: - Animations
    private func startAnimations() {
        withAnimation(.easeInOut(duration: DSTimeAnimation.slowXXL)) {
            self.scaleEffect = 1.2
            self.opacity = DSOpacity.one
        }
    }
    
    // MARK: - Navigation
    private func navigateAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + DSTimeAnimation.slowXXL) {
            self.onAnimationEnd()
        }
    }
}

#Preview {
    SplashScreenView(onAnimationEnd: {})
}


import SwiftUI
import DesignSystem

struct SplashScreenView: View {
    
    var onAnimationEnd: () -> Void
    
    @State private var scaleEffect = 0.8
    @State private var opacity = 0.0

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
        VStack {
            Spacer()
            animatedLogo()
            Spacer()
        }
    }
    
    // MARK: - Animated Logo
    @ViewBuilder
    private func animatedLogo() -> some View {
        Image("marvel_logo")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .scaleEffect(scaleEffect)
            .opacity(opacity)
    }
    
    // MARK: - Animations
    private func startAnimations() {
        withAnimation(.easeInOut(duration: 3.5)) {
            self.scaleEffect = 5
            self.opacity = 1.0
        }
    }
    
    // MARK: - Navigation
    private func navigateAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.onAnimationEnd()
        }
    }
}

#Preview {
    SplashScreenView(onAnimationEnd: {})
}


import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            MainView() // Verweist auf die Hauptnavigation
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                Image("splashscreen")
                    .resizable()
                    .scaledToFit()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

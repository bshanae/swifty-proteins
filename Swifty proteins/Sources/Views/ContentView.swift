import SwiftUI
import LocalAuthentication

struct IntroView: View {
    @EnvironmentObject var faceIDService: FaceIDService
    
	var body: some View {
		StartView()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		IntroView()
	}
}

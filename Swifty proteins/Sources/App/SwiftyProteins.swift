import SwiftUI

@main
struct SwiftyProteinsApp: App {
	@Environment(\.scenePhase) private var scenePhase
	
	@StateObject private var loginService = LoginService()
	
	public var body: some Scene {
		WindowGroup {
			currentPage
		}.onChange(of: scenePhase) { phase in
			if phase == .background {
				self.loginService.logOut()
			}
		}
	}

	private var currentPage: some View {
		if isShowingSplash {
			return AnyView(splashPage)
		} else {
			if loginService.isLoggedIn {
				return AnyView(moleculeListPage)
			} else {
				return AnyView(loginPage)
			}
		}
	}

	private var splashPage: some View {
		SplashPage()
			.onAppear(perform: startTimerForSplash)
	}

	private var loginPage: some View {
		LoginPage()
			.environmentObject(loginService)
	}

	private var moleculeListPage: some View {
		MoleculeListPage.View()
	}
	
	// MARK: - Splash
	
	private static let splashDuration = 3.0
	@State private var isShowingSplash = true
	
	private func startTimerForSplash() {
		DispatchQueue.main.asyncAfter(deadline: .now() + SwiftyProteinsApp.splashDuration) {
			self.isShowingSplash = false
		}
	}
}

import SwiftUI
import LocalAuthentication

struct LoginPage: View {
	
	@EnvironmentObject var loginService: LoginService
	
	public var body: some View {
		if !loginService.canLogIn {
			errorView
		} else {
			loginView
		}
	}
	
	private var errorView: some View {
		ZStack {
			VStack {
				Image(systemName: "lock.slash")
					.resizable()
					.frame(width: 25, height: 25)
					.foregroundColor(.red)
				
				Spacer().frame(height: 25)

				Text("Face ID is not supported")
					.font(.body)
					.foregroundColor(.red)
			}
		}
	}
	
	private var loginView: some View {
		VStack {
			Spacer()
			loginButton
			Spacer()
		}
	}

	private var loginButton: some View {
		Button(
			action: {
				self.loginService.logInWithFaceId()
			}, label: {
				ZStack {
					Circle()
						.fill(Assets.LoginPage.loginButtonColor)
						.shadow(color: Assets.accentColor, radius: 10.0)

					Image(systemName: "faceid")
						.resizable()
						.padding(25)
						.foregroundColor(Assets.accentColor)
				}
				.frame(width: 100.0, height: 100.0)
			}
		)
	}
}

struct LoginPage_Previews: PreviewProvider {
	static var previews: some View {
		LoginPage()
	}
}

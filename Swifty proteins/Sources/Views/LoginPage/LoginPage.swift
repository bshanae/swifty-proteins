import SwiftUI
import LocalAuthentication

struct LoginPage: View {
	@EnvironmentObject var loginService: LoginService
	
	public var body: some View {
		if !loginService.canLogIn {
			lockView
		} else {
			VStack() {
				loginView
					.fixedSize()

				if loginService.error != nil {
					Spacer()
						.frame(height: 50)

					Text(loginService.error ?? "Error")
						.foregroundColor(.red)
				}
			}
		}
	}
	
	// MARK: - Lock view
	
	private var lockView: some View {
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

	// MARK: - Login view
	
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
				buttonView
			}
		)
		.frame(width: 100.0, height: 100.0)
	}
	
	private var buttonView: some View {
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
}

struct LoginPage_Previews: PreviewProvider {
	static var previews: some View {
		LoginPage()
	}
}

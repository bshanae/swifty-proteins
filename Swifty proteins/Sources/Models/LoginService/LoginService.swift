import Foundation
import SwiftUI
import LocalAuthentication

class LoginService: ObservableObject {
    @Published public var isLoggedIn = false
	@Published public var error: String?

	public var canLogIn: Bool {
		let context = LAContext()
		var error: NSError? = nil
		
		let canEvaluate = context.canEvaluatePolicy(
			.deviceOwnerAuthenticationWithBiometrics,
			error: &error
		)

		return canEvaluate
	}

	public func logOut() {
		isLoggedIn = false
	}
    
    public func logInWithFaceId() {
        let context = LAContext()
		var error: NSError? = nil
        
        let canEvaluate = context.canEvaluatePolicy(
			.deviceOwnerAuthenticationWithBiometrics,
			error: &error
		)
        
        if canEvaluate {
            if context.biometryType != .none {
                context.evaluatePolicy(
					.deviceOwnerAuthenticationWithBiometrics,
					localizedReason: "To access your data"
				) { (success, error) in
					DispatchQueue.main.async {
						self.isLoggedIn = success
						self.error = error?.localizedDescription
					}
                }
            }
        }
    }
}

import Foundation
import SwiftUI
import LocalAuthentication

class LoginService: ObservableObject {
    @Published var isLoggedIn = false

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
					self.isLoggedIn = success
                }
            }
        }
    }
}

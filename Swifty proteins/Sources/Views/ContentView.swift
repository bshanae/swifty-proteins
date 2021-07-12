import SwiftUI
import LocalAuthentication

struct IntroView: View {
	
	enum AccessError {
		case notProblem
		case noFace
		case noBiometrics
	}
	
	@State var isActive:Bool = false
	
	@State private var isUnlocked = false
	
	@State private var accessError:AccessError = .notProblem
	
	let splashDelay = 2.5
	
	var body: some View {
		MoleculeListPage.View()
		
		//        ZStack {
		//            if self.isActive {
		//                VStack {
		//                    if self.isUnlocked {
		//						MoleculeListPage.View()
		//                    } else {
		//                        ZStack {
		//                            VStack {
		//                                if self.accessError == .noFace {
		//                                    Text("No Face")
		//                                } else if self.accessError == .noBiometrics {
		//                                    Text("No Biometrics")
		//                                }
		//                                Image(systemName: "lock.slash")
		//                            }
		//                        }
		//                    }
		//                }
		//                .onAppear(perform: authenticate)
		//            } else {
		//                Image("logo")
		//                .resizable()
		//                .aspectRatio(contentMode: .fit)
		//            }
		//        }.onAppear {
		//            DispatchQueue.main.asyncAfter(deadline: .now() + self.splashDelay) {
		//                withAnimation {
		//                    self.isActive = true
		//                }
		//            }
		//        }
	}
	
	func authenticate() {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "We need to unlock your data."
			
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				DispatchQueue.main.async {
					if success {
						self.isUnlocked = true
					} else {
						self.accessError = .noFace
					}
				}
			}
		} else {
			self.accessError = .noBiometrics
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		IntroView()
	}
}

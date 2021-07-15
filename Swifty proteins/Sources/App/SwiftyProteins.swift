import SwiftUI

@main
struct SwiftyProteinsApp: App {
    @StateObject var faceIDService = FaceIDService()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            IntroView().environmentObject(faceIDService)
        }.onChange(of: scenePhase) { phase in
            if phase == .background {
                self.faceIDService.appUnlocked = false
                self.faceIDService.authorizationError = nil
            }
        }
    }
}

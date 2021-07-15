//
//  StartView.swift
//  Swifty proteins
//
//  Created by Valeria Karon on 7/15/21.
//

import SwiftUI
import LocalAuthentication

struct StartView: View {
    
    @EnvironmentObject var faceIDService: FaceIDService
    
    @State var isSplash:Bool = true
    let splashDelay = 2.5
    
    var body: some View {
        ZStack {
            if self.isSplash {
                Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            } else {
                VStack {
                    if faceIDService.appUnlocked {
                        MoleculeListPage.View()
                    } else {
                        if faceIDService.authorizationError != nil {
                            ZStack {
                                VStack {
//									Text(appContext.authorizationError!.localizedDescription)
                                    Image(systemName: "lock.slash")
                                }
                            }
                        } else {
                            VStack {
                                Text("Swifty Proteins").font(.largeTitle)
                                Button(action: {self.faceIDService.requestBiometricUnlock()}) {
                                    ZStack {
                                        Color.white.frame(alignment:.center)
                                        Image(systemName: "faceid").resizable().padding().foregroundColor(.gray)
                                    }
                                    .frame(width: 100.0, height: 100.0)
                                    .shadow(color: Color.gray,
                                            radius: 10.0)
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.splashDelay) {
                withAnimation {
                    self.isSplash = false
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

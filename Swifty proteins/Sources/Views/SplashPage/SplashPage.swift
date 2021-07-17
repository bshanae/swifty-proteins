import SwiftUI

struct SplashPage: View {
	public var body: some View {
		Assets.SplashPage.logoImage
			.resizable()
			.frame(maxWidth: 400, maxHeight: 400)
			.aspectRatio(contentMode: .fit)
	}
}

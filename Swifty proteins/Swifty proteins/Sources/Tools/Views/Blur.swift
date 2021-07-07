import SwiftUI

struct Blur: UIViewRepresentable {
	public var style: UIBlurEffect.Style = .systemUltraThinMaterialDark
	public var backgroundColor = UIColor.white
	
	public func makeUIView(context: Context) -> UIVisualEffectView {
		let effect = UIVisualEffectView(effect: UIBlurEffect(style: style))
		effect.backgroundColor = backgroundColor

		return effect
	}
	
	public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
		uiView.effect = UIBlurEffect(style: style)
	}
}

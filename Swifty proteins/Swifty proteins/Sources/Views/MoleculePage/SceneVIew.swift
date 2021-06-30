import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
	
	private let scene: SCNScene
	private let view: SCNView

	private var onNodeSelected: (SCNNode?) -> ()
	private var backgroundColor: UIColor

	public init(using scene: SCNScene) {
		self.init(scene: scene)
	}

	private init(
		scene: SCNScene,
		onNodeSelected: @escaping (SCNNode?) -> () = { _ in },
		backgroundColor: UIColor = UIColor.white
	) {
		self.scene = scene
		self.view = SCNView()
		self.onNodeSelected = onNodeSelected
		self.backgroundColor = backgroundColor
	}

	public func backgroundColor(_ color: UIColor) -> SceneView {
		SceneView(scene: self.scene, onNodeSelected: self.onNodeSelected, backgroundColor: color)
	}

	public func onNodeSelected(_ onNodeSelected: @escaping (SCNNode?) -> ()) -> SceneView {
		SceneView(scene: self.scene, onNodeSelected: onNodeSelected, backgroundColor: self.backgroundColor)
	}
	
	public func makeUIView(context: Context) -> SCNView {
		view.scene = scene
		view.scene?.background.contents = backgroundColor

		view.pointOfView = scene.rootNode.childNode(withName: "camera", recursively: true)

		view.allowsCameraControl = true
		view.autoenablesDefaultLighting = true

		let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
		view.addGestureRecognizer(tapGesture)
		
		return view
	}
	
	public func updateUIView(_ view: SCNView, context: Context) {
	}
	
	public func makeCoordinator() -> Coordinator {
		Coordinator(view, onNodeSelected)
	}
	
	public class Coordinator: NSObject {
		private let view: SCNView
		private let onNodeSelected: (SCNNode?) -> ()

		init(_ view: SCNView, _ onNodeSelected: @escaping (SCNNode?) -> ()) {
			self.view = view
			self.onNodeSelected = onNodeSelected

			super.init()
		}
		
		@objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
			let tapPoint = gestureRecognize.location(in: view)
			let hitResults = view.hitTest(tapPoint, options: [:])

			onNodeSelected(hitResults[safe: 0]?.node)
		}
	}
}

import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
	private let scene: SCNScene
	private var view: Wrap<SCNView>

	private var onNodeSelected: ([SCNNode]) -> ()
	private var backgroundColor: Color

	public init(using scene: SCNScene) {
		self.init(scene: scene)
	}

	private init(
		scene: SCNScene,
		onNodeSelected: @escaping ([SCNNode]) -> () = { _ in },
		backgroundColor: Color = Color(UIColor.white)
	) {
		self.scene = scene
		self.onNodeSelected = onNodeSelected
		self.backgroundColor = backgroundColor
		self.view = Wrap(SCNView())
	}

	public func backgroundColor(_ color: Color) -> SceneView {
		SceneView(
			scene: self.scene,
			onNodeSelected: self.onNodeSelected,
			backgroundColor: color
		)
	}

	public func onNodeSelected(_ onNodeSelected: @escaping ([SCNNode]) -> ()) -> SceneView {
		SceneView(
			scene: self.scene,
			onNodeSelected: onNodeSelected,
			backgroundColor: self.backgroundColor
		)
	}

	public func makeSnapshot() -> UIImage {
		view.value.snapshot()
	}

	// MARK: - UIViewRepresentable

	public func makeUIView(context: Context) -> SCNView {
		view.value.scene = scene
		view.value.backgroundColor = UIColor(backgroundColor)

		view.value.allowsCameraControl = true
		view.value.autoenablesDefaultLighting = true
		view.value.antialiasingMode = .multisampling4X

		view.value.pointOfView = scene.rootNode.childNode(
			withName: "camera",
			recursively: true
		)

		let tapGesture = UITapGestureRecognizer(
			target: context.coordinator,
			action: #selector(context.coordinator.handleTap(_:))
		)

		view.value.addGestureRecognizer(tapGesture)
		
		return view.value
	}
	
	public func updateUIView(_ view: SCNView, context: Context) {
		self.view.value = view
		view.scene = scene
		context.coordinator.view = view
	}
	
	public func makeCoordinator() -> Coordinator {
		Coordinator(view: view.value, onNodeSelected: onNodeSelected)
	}
	
	// MARK: - Coordinator
	
	public class Coordinator: NSObject {
		public var view: SCNView
		public let onNodeSelected: ([SCNNode]) -> ()

		public init(view: SCNView, onNodeSelected: @escaping ([SCNNode]) -> ()) {
			self.view = view
			self.onNodeSelected = onNodeSelected
		}
		
		@objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
			let tapPoint = gestureRecognize.location(in: view)

			let hitResults = view.hitTest(
				tapPoint,
				options: [
					SCNHitTestOption.searchMode: SCNHitTestSearchMode.all.rawValue
				]
			)

			onNodeSelected(hitResults.map( {$0.node }))
		}
	}
}

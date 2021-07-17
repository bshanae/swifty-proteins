import SwiftUI
import SceneKit

struct MoleculeView: View {
	private let molecule: Molecule
	private let moleculeModel: MoleculeModel
	private let backgroundColor: Color
	private let onAtomSelected: (Atom?) -> ()

	private var sceneView = OptionalWrap<SceneView>()

	public init(
		molecule: Molecule,
		moleculeModel: MoleculeModel
	) {
		self.init(
			molecule: molecule,
			moleculeModel: moleculeModel,
			backgroundColor: Color(UIColor.white),
			onAtomSelected: { _ in }
		)
	}

	private init(
		molecule: Molecule,
		moleculeModel: MoleculeModel,
		backgroundColor: Color,
		onAtomSelected: @escaping (Atom?) -> ()
	) {
		self.molecule = molecule
		self.moleculeModel = moleculeModel
		self.backgroundColor = backgroundColor
		self.onAtomSelected = onAtomSelected
	}

	var body: some View {
		let scene = MoleculeView.generateScene(molecule: molecule, moleculeModel: moleculeModel)
		
		sceneView.value = SceneView(using: scene)
			.backgroundColor(backgroundColor)
			.onNodeSelected{ nodes in
				let atomNode = nodes.first(where: { !($0.name ?? "").isEmpty })

				guard let atomIndex = Int(atomNode?.name ?? "") else {
					onAtomSelected(nil)
					return
				}

				onAtomSelected(molecule.atoms[safe: atomIndex])
			}

		return sceneView.value!
	}

	public func backgroundColor(_ color: Color) -> MoleculeView {
		MoleculeView(
			molecule: self.molecule,
			moleculeModel: self.moleculeModel,
			backgroundColor: color,
			onAtomSelected: self.onAtomSelected
		)
	}

	public func onAtomSelected(_ onAtomSelected: @escaping (Atom?) -> ()) -> MoleculeView {
		MoleculeView(
			molecule: self.molecule,
			moleculeModel: self.moleculeModel,
			backgroundColor: self.backgroundColor,
			onAtomSelected: onAtomSelected
		)
	}

	private static func generateScene(molecule: Molecule, moleculeModel: MoleculeModel) -> SCNScene {
		let scene = SCNScene()
		scene.rootNode.addChildNode(generateMoleculeModel(molecule: molecule, moleculeModel: moleculeModel))

		return scene
	}
	
	private static func generateMoleculeModel(molecule: Molecule, moleculeModel: MoleculeModel) -> SCNNode {
		return selectMoleculeModelGenerator(moleculeModel: moleculeModel).generateModel(from: molecule)
	}

	private static func selectMoleculeModelGenerator(moleculeModel: MoleculeModel) -> MoleculeModelGenerator {
		switch moleculeModel {
		case .ballAndStick:
			return BallAndStickMoleculeModelGenerator()
		case .spaceFilling:
			return SpaceFillingMoleculeModelGenerator()
		}
	}

	public func makeSnapshot() -> UIImage {
		return sceneView.value!.makeSnapshot()
	}
}

import SceneKit

protocol MoleculeModelGenerator {
	func generateModel(from molecule: Molecule) -> SCNNode
}

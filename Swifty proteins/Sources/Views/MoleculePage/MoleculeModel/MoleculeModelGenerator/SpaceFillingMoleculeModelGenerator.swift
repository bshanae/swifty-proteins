import SceneKit

class SpaceFillingMoleculeModelGenerator: MoleculeModelGenerator {
	private static let atomScale = CGFloat(1.4)

	func generateModel(from molecule: Molecule) -> SCNNode {
		let root = SCNNode()
		
		for (index, atom) in molecule.atoms.enumerated() {
			root.addChildNode(SpaceFillingMoleculeModelGenerator.generateAtom(from: atom, usingIndex: index))
		}
		
		return root
	}
	
	private static func generateAtom(from atom: Atom, usingIndex index: Int) -> SCNNode {
		let geometry = SCNSphere(radius: atom.kind.radius * SpaceFillingMoleculeModelGenerator.atomScale)
		geometry.materials.first?.diffuse.contents = atom.kind.color
		
		let node = SCNNode(geometry: geometry)
		node.name = String(index)
		node.position = atom.position
		
		return node
	}
}


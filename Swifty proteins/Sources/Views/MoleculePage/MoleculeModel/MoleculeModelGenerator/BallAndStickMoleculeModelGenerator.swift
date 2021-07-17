import SceneKit

class BallAndStickMoleculeModelGenerator: MoleculeModelGenerator {
	private static let atomRadius = CGFloat(0.5)
	private static let connectionRadius = CGFloat(0.13)

	func generateModel(from molecule: Molecule) -> SCNNode {
		let root = SCNNode()
		
		for (index, atom) in molecule.atoms.enumerated() {
			root.addChildNode(BallAndStickMoleculeModelGenerator.generateAtom(from: atom, usingIndex: index))
		}

		for bound in molecule.bounds {
			let startAtom = molecule.atoms[safe: bound.atomId]
			let endAtom = molecule.atoms[safe: bound.boundAtomId]

			if startAtom != nil && endAtom != nil {
				root.addChildNode(BallAndStickMoleculeModelGenerator.generateBound(start: startAtom!, end: endAtom!))
			} else {
				print("Can't create bound for atom with indices \(bound.atomId) and \(bound.boundAtomId)")
			}
		}
		
		return root
	}
	
	private static func generateAtom(from atom: Atom, usingIndex index: Int) -> SCNNode {
		let geometry = SCNSphere(radius: BallAndStickMoleculeModelGenerator.atomRadius)
		geometry.materials.first?.diffuse.contents = atom.kind.color
		
		let node = SCNNode(geometry: geometry)
		node.name = String(index)
		node.position = atom.position
		
		return node
	}

	private static func generateBound(start startAtom: Atom, end endAtom: Atom) -> SCNNode {
		let distanceBetweenAtoms = distance(startAtom.position, endAtom.position)
		let centerBetweenAtoms = startAtom.position + (endAtom.position - startAtom.position) / 2

		let geometry = SCNCylinder(radius: connectionRadius, height: CGFloat(distanceBetweenAtoms))
		geometry.materials.first?.diffuse.contents = UIColor.lightGray
		
		let node = SCNNode(geometry: geometry)
		node.position = centerBetweenAtoms
		node.look(at: endAtom.position, up: SCNVector3(1, 0, 0), localFront: SCNVector3(0, 1, 0))
		
		return node
	}
}


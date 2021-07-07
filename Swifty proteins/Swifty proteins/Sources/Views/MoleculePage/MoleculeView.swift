import SwiftUI
import SceneKit

struct MoleculeView: View {
	private static let atomRadius = CGFloat(0.5)
	private static let connectionRadius = CGFloat(0.13)
	
	private let molecule: Molecule
	private let backgroundColor: Color
	private let onAtomSelected: (Atom?) -> ()

	public init(from molecule: Molecule) {
		self.init(molecule: molecule)
	}

	private init(
		molecule: Molecule,
		backgroundColor: Color = Color(UIColor.white),
		onAtomSelected: @escaping (Atom?) -> () = { _ in }
	) {
		self.molecule = molecule
		self.backgroundColor = backgroundColor
		self.onAtomSelected = onAtomSelected
	}

	var body: some View {
		SceneView(using: MoleculeView.generateScene(by: molecule))
			.backgroundColor(backgroundColor)
			.onNodeSelected{ nodes in
				let atomNode = nodes.first(where: { !($0.name ?? "").isEmpty })

				guard let atomIndex = Int(atomNode?.name ?? "") else {
					onAtomSelected(nil)
					return
				}

				onAtomSelected(molecule.atoms[safe: atomIndex])
			}
	}

	public func backgroundColor(_ color: Color) -> MoleculeView {
		MoleculeView(
			molecule: self.molecule,
			backgroundColor: color,
			onAtomSelected: self.onAtomSelected
		)
	}

	public func onAtomSelected(_ onAtomSelected: @escaping (Atom?) -> ()) -> MoleculeView {
		MoleculeView(
			molecule: self.molecule,
			backgroundColor: self.backgroundColor,
			onAtomSelected: onAtomSelected
		)
	}

	private static func generateScene(by molecule: Molecule) -> SCNScene {
		let scene = SCNScene()
		scene.rootNode.addChildNode(generateMolecule(from: molecule))

		return scene
	}
	
	private static func generateMolecule(from molecule: Molecule) -> SCNNode {
		let root = SCNNode()
		
		for (index, atom) in molecule.atoms.enumerated() {
			root.addChildNode(generateAtom(from: atom, usingIndex: index))
		}

		for bound in molecule.bounds {
			let startAtom = molecule.atoms[safe: bound.atomId]
			let endAtom = molecule.atoms[safe: bound.boundAtomId]

			if startAtom != nil && endAtom != nil {
				root.addChildNode(generateBound(start: startAtom!, end: endAtom!))
			} else {
				print("Can't create bound for atom with indices \(bound.atomId) and \(bound.boundAtomId)")
			}
		}
		
		return root
	}
	
	private static func generateAtom(from atom: Atom, usingIndex index: Int) -> SCNNode {
		let geometry = SCNSphere(radius: atomRadius)
		geometry.materials.first?.diffuse.contents = atom.element.color
		
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

struct MoleculeView_Previews: PreviewProvider {
    static var previews: some View {
		MoleculeView(from: MoleculeService().getDescription(ofMolecule: "001")).preferredColorScheme(.light)
		MoleculeView(from: MoleculeService().getDescription(ofMolecule: "001")).preferredColorScheme(.dark)
    }
}

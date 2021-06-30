import Foundation
import SceneKit

class MoleculeService {
	public static func getDescription(ofMolecule moleculeId: String) -> Molecule {
		return Molecule(
			atoms: [
				Atom(
					position: SCNVector3(0, 0, 0),
					kind: .C
				),
				Atom(
					position: SCNVector3(-1, 1, 2),
					kind: .H
				),
				Atom(
					position: SCNVector3(1, -2, -2),
					kind: .H
				),
				Atom(
					position: SCNVector3(1, 2, -2),
					kind: .C
				),
				Atom(
					position: SCNVector3(-2, -2, 1),
					kind: .C
				),
			],
			connections: [
				(0, 1),
				(0, 2),
				(0, 3),
				(0, 4)
			]
		)
	}
}

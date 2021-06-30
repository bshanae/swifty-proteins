import SceneKit

struct Atom {
	
	enum Kind: String {
		case H
		case C
	}

	let position: SCNVector3
	let kind: Kind

	var color: UIColor {
		switch kind {
		case .H:
			return UIColor.red
		case .C:
			return UIColor.blue
		}
	}
}

import SceneKit

struct Atom {
	
	enum Kind: String {
		case H
		case C
        case N
        case O
        case F
        case Cl
        case Br
        case I
        case He
        case Ne
        case Ar
        case Xe
        case Kr
        case P
        case S
        case B
        case Li
        case Na
        case K
        case Rb
        case Cs
        case Fr
        case Be
        case Mg
        case Ca
        case Sr
        case Ba
        case Ra
        case Ti
        case Fe
        case other
	}
    
    let id: Int
	let position: SCNVector3
	let kind: Kind

    init(id:Int, stringKind:String, x: Double, y: Double, z: Double){
        self.id = id
        self.position = SCNVector3.init(x, y, z)
        self.kind = Kind.init(rawValue: stringKind) ?? Kind.other
    }
    
	var color: UIColor {
		switch kind {
		case .H:
            return UIColor.white
		case .C:
			return UIColor.black
        case .N:
            return UIColor.blue
        case .O:
            return UIColor.white
        case .F, .Cl:
            return UIColor.green
        case .Br:
            return UIColor.init(red: 0.6, green: 0.13, blue: 0.0, alpha: 1.0)
        case .I:
            return UIColor.init(red: 0.4, green: 0.0, blue: 0.73, alpha: 1.0)
        case .He, .Ne, .Ar, .Xe, .Kr:
            return UIColor.cyan
        case .P:
            return UIColor.orange
        case .S:
            return UIColor.yellow
        case .B:
            return UIColor.init(red: 1.0, green: 0.67, blue: 0.47, alpha: 1.0)
        case .Li, .Na, .K, .Rb, .Cs, .Fr:
            return UIColor.init(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0)
        case .Be, .Mg, .Ca, .Sr, .Ba, .Ra:
            return UIColor.init(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0)
        case .Ti:
            return UIColor.gray
        case .Fe:
            return UIColor.init(red: 0.87, green: 0.47, blue: 0.0, alpha: 1.0)
        case .other:
            return UIColor.systemPink
		}
	}
    
    var name: String {
        switch kind {
        case .H:
            return "hydrogen"
        case .C:
            return "carbon"
        case .N:
            return "nitrogen"
        case .O:
            return "oxygen"
        case .F:
            return "fluorine"
        case .Cl:
            return "chlorine"
        case .Br:
            return "bromine"
        case .I:
            return "iodine"
        case .He, .Ne, .Ar, .Xe, .Kr:
            return "noble gases"
        case .P:
            return "phosphorus"
        case .S:
            return "sulfur"
        case .B:
            return "boron"
        case .Li, .Na, .K, .Rb, .Cs, .Fr:
            return "alkali metals"
        case .Be, .Mg, .Ca, .Sr, .Ba, .Ra:
            return "alkaline earth metals"
        case .Ti:
            return "titanium"
        case .Fe:
            return "iron"
        case .other:
            return "other elements"
        }
    }
}

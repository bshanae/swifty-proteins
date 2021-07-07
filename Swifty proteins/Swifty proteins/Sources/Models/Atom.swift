import SceneKit

struct Atom {
    struct Element {
        let color: UIColor
        let name: String
        let atomRadius: CGFloat
        
        init(_ name: String, _ color: UIColor, _ atomRadius: CGFloat) {
            self.color = color
            self.name = name
            self.atomRadius = atomRadius
        }
    }
    
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
        case Al
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
    
    var element: Element{
		switch kind {
		case .H:
            return Element("hydrogen", UIColor.white, 0.3)
		case .C:
			return Element("carbon", UIColor.black, 0.77)
        case .N:
            return Element("nitrogen", UIColor.blue, 0.73)
        case .O:
            return Element("oxygen", UIColor.white, 0.74)
        case .F:
            return Element("fluorine", UIColor.green, 0.71)
        case .Cl:
            return Element("chlorine", UIColor.green, 0.99)
        case .Br:
            return Element("bromine", UIColor(red: 0.6, green: 0.13, blue: 0.0, alpha: 1.0), 1.14)
        case .I:
            return Element("iodine", UIColor(red: 0.4, green: 0.0, blue: 0.73, alpha: 1.0), 1.33)
        case .He:
            return Element("helium", UIColor.cyan, 0.93)
        case .Ne:
            return Element("neon", UIColor.cyan, 1.12)
        case .Ar:
            return Element("argon", UIColor.cyan, 1.54)
        case .Xe:
            return Element("xenon", UIColor.cyan, 1.9)
        case .Kr:
            return Element("krypton", UIColor.cyan, 1.69)
        case .P:
            return Element("phosphorus", UIColor.orange, 1.1)
        case .S:
            return Element("sulfur", UIColor.yellow, 1.03)
        case .B:
            return Element("boron", UIColor(red: 1.0, green: 0.67, blue: 0.47, alpha: 1.0), 0.8)
        case .Li:
            return Element("lithium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 1.52)
        case .Na:
            return Element("sodium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 1.86)
        case .K:
            return Element("potassium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.27)
        case .Rb:
            return Element("rubidium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.48)
        case .Cs:
            return Element("cesium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.66)
        case .Fr:
            return Element("francium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.8)
        case .Be:
            return Element("beryllium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.11)
        case .Mg:
            return Element("magnesium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.6)
        case .Ca:
            return Element("calcium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.97)
        case .Sr:
            return Element("strontium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.15)
        case .Ba:
            return Element("barium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.17)
        case .Ra:
            return Element("radium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.2)
        case .Ti:
            return Element("titanium", UIColor.gray, 1.45)
        case .Fe:
            return Element("iron", UIColor(red: 0.87, green: 0.47, blue: 0.0, alpha: 1.0), 1.24)
        case .Al:
            return Element("aluminium", UIColor.systemPink, 1.43)
        case .other:
            return Element("other elements", UIColor.systemPink, 0.3)
		}
    }
}

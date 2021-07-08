import SwiftUI

extension Atom {
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
		
		public var name: String {
			info.0
		}
		
		public var color: UIColor {
			info.1
		}
		
		public var radius: CGFloat {
			info.2
		}

		private var info: (String, UIColor, CGFloat) {
			switch self {
			case .H:
				return ("hydrogen", UIColor.white, 0.3)
			case .C:
				return ("carbon", UIColor.gray, 0.77)
			case .N:
				return ("nitrogen", UIColor.blue, 0.73)
			case .O:
				return ("oxygen", UIColor.white, 0.74)
			case .F:
				return ("fluorine", UIColor.green, 0.71)
			case .Cl:
				return ("chlorine", UIColor.green, 0.99)
			case .Br:
				return ("bromine", UIColor(red: 0.6, green: 0.13, blue: 0.0, alpha: 1.0), 1.14)
			case .I:
				return ("iodine", UIColor(red: 0.4, green: 0.0, blue: 0.73, alpha: 1.0), 1.33)
			case .He:
				return ("helium", UIColor.cyan, 0.93)
			case .Ne:
				return ("neon", UIColor.cyan, 1.12)
			case .Ar:
				return ("argon", UIColor.cyan, 1.54)
			case .Xe:
				return ("xenon", UIColor.cyan, 1.9)
			case .Kr:
				return ("krypton", UIColor.cyan, 1.69)
			case .P:
				return ("phosphorus", UIColor.orange, 1.1)
			case .S:
				return ("sulfur", UIColor.yellow, 1.03)
			case .B:
				return ("boron", UIColor(red: 1.0, green: 0.67, blue: 0.47, alpha: 1.0), 0.8)
			case .Li:
				return ("lithium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 1.52)
			case .Na:
				return ("sodium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 1.86)
			case .K:
				return ("potassium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.27)
			case .Rb:
				return ("rubidium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.48)
			case .Cs:
				return ("cesium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.66)
			case .Fr:
				return ("francium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.8)
			case .Be:
				return ("beryllium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.11)
			case .Mg:
				return ("magnesium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.6)
			case .Ca:
				return ("calcium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.97)
			case .Sr:
				return ("strontium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.15)
			case .Ba:
				return ("barium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.17)
			case .Ra:
				return ("radium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.2)
			case .Ti:
				return ("titanium", UIColor.gray, 1.45)
			case .Fe:
				return ("iron", UIColor(red: 0.87, green: 0.47, blue: 0.0, alpha: 1.0), 1.24)
			case .Al:
				return ("aluminium", UIColor.systemPink, 1.43)
			case .other:
				return ("other elements", UIColor.systemPink, 0.3)
			}
		}
	}
}

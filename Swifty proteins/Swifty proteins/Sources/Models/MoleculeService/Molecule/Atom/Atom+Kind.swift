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
				return ("Hydrogen", UIColor.white, 0.3)
			case .C:
				return ("Carbon", UIColor.gray, 0.77)
			case .N:
				return ("Nitrogen", UIColor.blue, 0.73)
			case .O:
				return ("Oxygen", UIColor.white, 0.74)
			case .F:
				return ("Fluorine", UIColor.green, 0.71)
			case .Cl:
				return ("Chlorine", UIColor.green, 0.99)
			case .Br:
				return ("Bromine", UIColor(red: 0.6, green: 0.13, blue: 0.0, alpha: 1.0), 1.14)
			case .I:
				return ("Iodine", UIColor(red: 0.4, green: 0.0, blue: 0.73, alpha: 1.0), 1.33)
			case .He:
				return ("Helium", UIColor.cyan, 0.93)
			case .Ne:
				return ("Neon", UIColor.cyan, 1.12)
			case .Ar:
				return ("Argon", UIColor.cyan, 1.54)
			case .Xe:
				return ("Xenon", UIColor.cyan, 1.9)
			case .Kr:
				return ("Krypton", UIColor.cyan, 1.69)
			case .P:
				return ("Phosphorus", UIColor.orange, 1.1)
			case .S:
				return ("Sulfur", UIColor.yellow, 1.03)
			case .B:
				return ("Boron", UIColor(red: 1.0, green: 0.67, blue: 0.47, alpha: 1.0), 0.8)
			case .Li:
				return ("Lithium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 1.52)
			case .Na:
				return ("Sodium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 1.86)
			case .K:
				return ("Potassium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.27)
			case .Rb:
				return ("Rubidium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.48)
			case .Cs:
				return ("Cesium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.66)
			case .Fr:
				return ("Francium", UIColor(red: 0.47, green: 0.0, blue: 1.0, alpha: 1.0), 2.8)
			case .Be:
				return ("Beryllium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.11)
			case .Mg:
				return ("Magnesium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.6)
			case .Ca:
				return ("Calcium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 1.97)
			case .Sr:
				return ("Strontium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.15)
			case .Ba:
				return ("Barium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.17)
			case .Ra:
				return ("Radium", UIColor(red: 0.0, green: 0.47, blue: 0.0, alpha: 1.0), 2.2)
			case .Ti:
				return ("Titanium", UIColor.gray, 1.45)
			case .Fe:
				return ("Iron", UIColor(red: 0.87, green: 0.47, blue: 0.0, alpha: 1.0), 1.24)
			case .Al:
				return ("Aluminium", UIColor.systemPink, 1.43)
			case .other:
				return ("Other", UIColor.systemPink, 0.3)
			}
		}
	}
}

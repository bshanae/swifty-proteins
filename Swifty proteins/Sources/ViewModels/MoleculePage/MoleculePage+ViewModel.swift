import Foundation

extension MoleculePage {
	class ViewModel: ObservableObject {
		@Published public var moleculeModel: MoleculeModel = .ballAndStick
		
		public func toggleMoleculeModel() {
			switch moleculeModel {
			case .ballAndStick:
				moleculeModel = .spaceFilling
			case .spaceFilling:
				moleculeModel = .ballAndStick
			}
		}
	}
}

import Combine

class MoleculeRequest: ObservableObject {
	public enum Status {
		case pending
		case error(message: String)
		case success(molecule: Molecule)
	}
	
	@Published public var status: Status = .pending
}

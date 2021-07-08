import Combine

class MoleculeRequest: ObservableObject {
	public enum Status {
		case pending
		case error
		case success(Molecule)
	}
	
	@Published var status: Status = .pending
}

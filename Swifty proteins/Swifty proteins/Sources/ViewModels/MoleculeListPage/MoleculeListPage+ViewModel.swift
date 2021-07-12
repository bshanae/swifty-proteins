import Foundation
import Combine

extension MoleculeListPage {
	class ViewModel: ObservableObject {
		private func reset() {
			requestedMoleculeId = nil
			
			loadedMoleculeId = nil
			loadedMolecule = nil

			error = nil
			
			errorTimer?.invalidate()
			errorTimer = nil

			moleculeRequest = nil
			moleculeSubscription = nil
		}
		
		@Published public var filter = ""

		public var moleculeIds: [String] {
			do {
				let url = Bundle.main.path(forResource: "ligands", ofType: "txt", inDirectory: "")!
				let contents = try String(contentsOfFile: url)
				
				let rawIds = contents.split(separator: "\n").map{ String($0) }

				let filteredIds = rawIds.filter{
					filter.isEmpty || $0.lowercased().contains(filter.lowercased())
				}

				return filteredIds
			} catch {
				print(error)
				return []
			}
		}

		@Published public var requestedMoleculeId: String?

		@Published public var loadedMoleculeId: String?
		@Published public var loadedMolecule: Molecule?

		@Published public var error: String?
		private var errorTimer: Timer?

		public var isLoading: Bool {
			requestedMoleculeId != nil
		}

		private var moleculeRequest: MoleculeRequest?
		private var moleculeSubscription: AnyCancellable?

		public func requestMolecule(withId id: String) {
			reset()

			requestedMoleculeId = id

			moleculeRequest = MoleculeService.requestMolecule(withId: id)
			moleculeSubscription = moleculeRequest!.$status.sink(receiveValue: onRequestChanged)
		}

		private func onRequestChanged(status: MoleculeRequest.Status) {
			switch status {
			case .pending:
				break

			case .error(let message):
				requestedMoleculeId = nil
				error = message
				
				errorTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false){ _ in
					self.error = nil
				}
				
			case .success(let molecule):
				requestedMoleculeId = nil
				loadedMolecule = molecule
				loadedMoleculeId = molecule.id
			}
		}
	}
}

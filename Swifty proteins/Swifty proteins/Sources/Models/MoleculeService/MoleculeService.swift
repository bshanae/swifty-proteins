import Foundation

class MoleculeService {
	public static func requestMolecule(ofMolecule moleculeId: String) -> MoleculeRequest {
		let moleculeRequest = MoleculeRequest()
		
		downloadMolecule(
			ofMolecule: moleculeId,
			onResult: { (data, error) in
				if error != nil {
					moleculeRequest.status = .error
				} else {
					moleculeRequest.status = .success(parseMolecule(moleculeId: moleculeId, file: data!))
				}
			})
		
		return moleculeRequest
	}
	
	private static func parseMolecule(moleculeId: String, file: String) -> Molecule {
		var atoms = [Atom]()
		var bounds = [Bound]()
		
		let lines = file.components(separatedBy: .newlines)
		if lines[0] == moleculeId.uppercased() {
			var i = 1
			var statusData = false
			var atomCount = 0
			var linkCount = 0
			var id = 1
			for line in lines {
				let info = line.components(separatedBy: .whitespaces).filter({ $0 != "" })
				if (statusData == false) && (i == 4){
					atomCount = Int(info[0]) ?? 0
					linkCount = Int(info[1]) ?? 0
					statusData = true
				} else if statusData && (i < 5 + atomCount){
					atoms.append(Atom.parse(
						id: id,
						stringKind: String(info[3]),
						x: Double(info[0]) ?? 0.0,
						y: Double(info[1]) ?? 0.0,
						z: Double(info[2]) ?? 0.0
					))
					id += 1
				} else if statusData && (i < 5 + atomCount + linkCount) {
					let atomId = Int(info[0]) ?? 0
					let boundAtomId = (Int(info[1]) ?? 0)
					let typeOfBound = (Int(info[2]) ?? 0)
					
					bounds.append(
						Bound.parse(
							atomId: atomId,
							boundAtomId: boundAtomId,
							typeOfBound: typeOfBound
						)
					)
				}
				i += 1
			}
		}
		
		return Molecule(atoms: atoms, bounds: bounds)
	}
	
	
	private static func downloadMolecule(
		ofMolecule moleculeId: String,
		onResult: @escaping (_ data: String?, _ error: String?) -> ()
	) {
		let urlAsString = "https://files.rcsb.org/ligands/view/\(moleculeId.uppercased())_model.sdf"
		guard let urlToGet = URL(string: urlAsString) else {
			onResult(nil, "Can't create URL")
			return
		}
		
		let session = URLSession.shared
		let sessionTask = session.dataTask(
			with: urlToGet,
			completionHandler: { (data, response, error) in
				guard let data = data else {
					onResult(nil, error!.localizedDescription)
					return
				}
				
				onResult(String(data: data, encoding: .utf8), nil)
			})
		
		sessionTask.resume()
	}
}

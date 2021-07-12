import Foundation
import Alamofire

class MoleculeService {
	public static func requestMolecule(withId moleculeId: String) -> MoleculeRequest {
		let moleculeRequest = MoleculeRequest()
		
		downloadMolecule(
			ofMolecule: moleculeId,
			onResult: { (data, error) in
				if error != nil {
					moleculeRequest.status = .error(message: error!)
				} else {
					moleculeRequest.status = .success(molecule: parseMolecule(moleculeId: moleculeId, file: data!))
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
			var boundCount = 0
			var id = 1
			for line in lines {
				let info = line.components(separatedBy: .whitespaces).filter({ $0 != "" })
				if (statusData == false) && (i == 4){
					atomCount = Int(info[0]) ?? 0
					boundCount = Int(info[1]) ?? 0
					statusData = true
				} else if statusData && (i < 5 + atomCount){
					atoms.append(Atom.parse(
						id: id - 1,
						stringKind: String(info[3]),
						x: Double(info[0]) ?? 0.0,
						y: Double(info[1]) ?? 0.0,
						z: Double(info[2]) ?? 0.0
					))
					id += 1
				} else if statusData && (i < 5 + atomCount + boundCount) {
					let atomId = (Int(info[0]) ?? 1) - 1
					let boundAtomId = (Int(info[1]) ?? 1) - 1
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
		
		return Molecule(id: moleculeId, atoms: atoms, bounds: bounds)
	}
	
	
	private static func downloadMolecule(
		ofMolecule moleculeId: String,
		onResult: @escaping (_ data: String?, _ error: String?) -> ()
	) {
		let url = "https://files.rcsb.org/ligands/view/\(moleculeId.uppercased())_ideal.sdf"

		AF
			.download(url)
			.validate()
			.responseData{ response in
				if response.value != nil {
					onResult(String(data: response.value!, encoding: String.Encoding.utf8), nil)
				} else {
					onResult(nil, response.error?.localizedDescription)
				}
			}
	}
}

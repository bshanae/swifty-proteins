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
			var id = 0
			for line in lines {
				let info = line.components(separatedBy: .whitespaces).filter({ $0 != "" })
				if (i > 4) {
                    if String(info[0]).isEqual("M") {
                        break
                    }
                    if info.count > 7 {
                        atoms.append(Atom.parse(
							id: id,
							stringKind: String(info[3]),
							x: Double(info[0]) ?? 0.0,
							y: Double(info[1]) ?? 0.0,
							z: Double(info[2]) ?? 0.0
						))
						id += 1
                    } else {
                        let index1 = line.index(line.startIndex, offsetBy: 3)
                        let index2 = line.index(line.startIndex, offsetBy: 6)
                        let index3 = line.index(line.startIndex, offsetBy: 9)
                        var tmp = String(line[..<index1]).trimmingCharacters(in: .whitespacesAndNewlines)
                        let atomId = (Int(tmp) ?? 2) - 1
                        tmp = String(line[index1..<index2]).trimmingCharacters(in: .whitespacesAndNewlines)
                        let boundAtomId = (Int(tmp) ?? 2) - 1
                        tmp = String(line[index2..<index3]).trimmingCharacters(in: .whitespacesAndNewlines)
                        let typeOfBound = Int(tmp) ?? 1
                        bounds.append(
							Bound.parse(
								atomId: atomId,
								boundAtomId: boundAtomId,
								typeOfBound: typeOfBound
							)
						)
                    }
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

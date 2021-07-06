import Foundation
import SceneKit
import SwiftUI

class MoleculeService {
	public static func getDescription(ofMolecule moleculeId: String) -> Molecule {
        var molecule = Molecule(atoms: [], bounds: [] )
        let urlToGet = URL(string: "https://files.rcsb.org/ligands/view/\(moleculeId.uppercased())_model.sdf")!
        URLSession.shared.dataTask(with: urlToGet) { data, response, error in
            guard let data = data else { return }
            let file = String(data: data, encoding: .utf8)
            let lines = file?.components(separatedBy: .newlines)
            if lines![0] == moleculeId.uppercased() {
                var i = 1
                var statusData = false
                var atomCount = 0
                var linkCount = 0
                var id = 1
                for line in lines! {
                    let info = line.components(separatedBy: .whitespaces).filter({ $0 != "" })
                    if (statusData == false) && (i == 4){
                        atomCount = Int(info[0]) ?? 0
                        linkCount = Int(info[1]) ?? 0
                        statusData = true
                    } else if statusData && (i < 5 + atomCount){
                        let newAtom = Atom(id: id,
                                           stringKind: String(info[3]),
                                           x: Double(info[0]) ?? 0.0,
                                           y: Double(info[1]) ?? 0.0,
                                           z: Double(info[2]) ?? 0.0)
                        molecule.atoms.append(newAtom)
                        id += 1
                    } else if statusData && (i < 5 + atomCount + linkCount) {
                        let atomId = Int(info[0]) ?? 0
                        let boundAtomId = Int(info[1]) ?? 0
                        let typeOfBound = Int(info[2]) ?? 1
                        molecule.bounds.append(Bound(atomId: atomId, boundAtomId: boundAtomId, typeOfBound: typeOfBound))
                    }
                    i += 1
                }
            }
        }.resume()
        return molecule
	}
}

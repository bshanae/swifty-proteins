import SwiftUI

struct MoleculePage: View {
	@State
	private var selectedAtom: Atom?
	
	var body: some View {
		ZStack {
			Color(UIColor.darkGray)
				.ignoresSafeArea()
			
			MoleculeView(by: MoleculeService.getDescription(ofMolecule: ""))
				.backgroundColor(UIColor.darkGray)
				.onAtomSelected{ selectedAtom in
					self.selectedAtom = selectedAtom
				}
			
			if selectedAtom != nil {
				VStack {
					Spacer()
					messageAboutSelectedAtom
				}
			}
		}
	}

	var messageAboutSelectedAtom: some View {
		ZStack {
			Rectangle()
				.fill(Color(UIColor.gray))
				.frame(width: 200, height: 100)
				.cornerRadius(5)

			if selectedAtom != nil {
				Text("You've selected atom \(selectedAtom!.kind.rawValue)")
			}
		}
	}
}

struct MoleculePage_Previews: PreviewProvider {
	static var previews: some View {
		MoleculePage()
	}
}

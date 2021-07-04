import SwiftUI

struct MoleculePage: View {
	@State
	private var selectedAtom: Atom?
	
	var body: some View {
		
			ZStack {
				moleculeView
				
				if selectedAtom != nil {
					VStack {
						Spacer()
						messageAboutSelectedAtom
					}
				}
			}
			.navigationBarTitle(Text("Hello"), displayMode: .inline)
			.navigationBarItems(trailing: shareButton)
		
	}
	
	var moleculeView: some View {
		MoleculeView(from: MoleculeService.getDescription(ofMolecule: ""))
			.backgroundColor(Assets.MoleculePage.BackgroundColor)
			.onAtomSelected{ selectedAtom in
				self.selectedAtom = selectedAtom
			}
			.ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
	}
	
	var shareButton: some View {
		Button(action: {}) {
			Image(systemName: "square.and.arrow.up")
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
		MoleculePage().preferredColorScheme(.light)
		MoleculePage().preferredColorScheme(.dark)
	}
}

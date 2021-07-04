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
				.background(
					Blur(
						style: .systemUltraThinMaterial,
						backgroundColor: UIColor(white: 0.5, alpha: 0.4)
					)
				)
				.foregroundColor(Color.gray.opacity(0))
				.frame(width: 100, height: 100)
				.cornerRadius(20)
			
			if selectedAtom != nil {
				Text("\(selectedAtom!.kind.rawValue)")
					.font(.title)
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

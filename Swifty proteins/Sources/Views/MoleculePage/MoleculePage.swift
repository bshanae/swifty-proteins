import SwiftUI

struct MoleculePage {
	struct View: SwiftUI.View {
		@State private var selectedAtom: Atom?
		
		private let molecule: Molecule
		
		public init(ofMolecule molecule: Molecule) {
			self.molecule = molecule
		}
		
		var body: some SwiftUI.View {
			ZStack {
				moleculeView
				
				if selectedAtom != nil {
					VStack {
						Spacer()
						messageAboutSelectedAtom
						Spacer().frame(height: 20)
					}
				}
			}
			.navigationBarTitle(Text(molecule.id), displayMode: .inline)
			.navigationBarItems(trailing: shareButton)
		}
		
		var moleculeView: some SwiftUI.View {
			MoleculeView(from: molecule)
				.backgroundColor(Assets.MoleculePage.BackgroundColor)
				.onAtomSelected{ selectedAtom in
					self.selectedAtom = selectedAtom
				}
				.ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
		}
		
		var shareButton: some SwiftUI.View {
			Button(action: {}) {
				Image(systemName: "square.and.arrow.up")
			}
		}
		
		var messageAboutSelectedAtom: some SwiftUI.View {
			Text("\(selectedAtom?.kind.name ?? "?")")
				.font(.title)
				.padding(18)
				.background(
					Rectangle()
						.background(
							Blur(
								style: .systemUltraThinMaterial,
								backgroundColor: UIColor(white: 0.5, alpha: 0.4)
							)
						)
						.foregroundColor(Color.gray.opacity(0))
						.cornerRadius(5)
				)
		}
	}
}

//struct MoleculePage_Previews: PreviewProvider {
//	static var previews: some SwiftUI.View {
//		MoleculePage().preferredColorScheme(.light)
//		MoleculePage().preferredColorScheme(.dark)
//	}
//}

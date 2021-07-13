import SwiftUI

struct MoleculePage {
	struct View: SwiftUI.View {
		@State private var selectedAtom: Atom?
		
		private let molecule: Molecule
		private let temporary: Temporary
		
		public init(ofMolecule molecule: Molecule) {
			self.molecule = molecule
			self.temporary = Temporary()
		}
		
		var body: some SwiftUI.View {
			ZStack {
				makeMoleculeView()
					.ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
				
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
		
		// MARK: - Molecule view
		
		private func makeMoleculeView() -> MoleculeView {
			temporary.moleculeView = MoleculeView(from: molecule)
				.backgroundColor(Assets.MoleculePage.BackgroundColor)
				.onAtomSelected{ selectedAtom in
					self.selectedAtom = selectedAtom
				}

			return temporary.moleculeView!
		}

		private class Temporary {
			public var moleculeView: MoleculeView?
		}

		// MARK: - Share button
		
		var shareButton: some SwiftUI.View {
			Button(
				action: {
					if temporary.moleculeView != nil {
						ImageSharingService.share(image: temporary.moleculeView!.makeSnapshot())
					}
				},
				label: {
					Image(systemName: "square.and.arrow.up")
				}
			)
		}

		// MARK: - Message
		
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

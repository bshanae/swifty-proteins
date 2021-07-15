import SwiftUI

struct MoleculePage {
	struct View: SwiftUI.View {
		private let molecule: Molecule

		@StateObject private var viewModel = ViewModel()
		@State private var selectedAtom: Atom?

		private var moleculeView = Wrap<MoleculeView>()
		private var lastMoleculeModel = Wrap<MoleculeModel>()
		
		public init(ofMolecule molecule: Molecule) {
			self.molecule = molecule
		}
		
		var body: some SwiftUI.View {
			return ZStack {
				getOrMakeMoleculeView()
					.ignoresSafeArea(edges: .bottom)
				
				if selectedAtom != nil {
					VStack {
						Spacer()
						messageAboutSelectedAtom
						Spacer().frame(height: 20)
					}
				}
			}
			.navigationBarTitle(Text(molecule.id), displayMode: .inline)
			.navigationBarItems(trailing:
				HStack(spacing: 5) {
					toggleModelButton
					shareButton
				}
			)
		}

		// MARK: - Molecule view
		
		private func getOrMakeMoleculeView() -> MoleculeView {
			if (viewModel.moleculeModel == lastMoleculeModel.value && moleculeView.hasValue) {
				return moleculeView.value!
			}

			lastMoleculeModel.value = viewModel.moleculeModel

			moleculeView.value = MoleculeView(molecule: molecule, moleculeModel: viewModel.moleculeModel)
				.backgroundColor(Assets.MoleculePage.BackgroundColor)
				.onAtomSelected { selectedAtom in
					self.selectedAtom = selectedAtom
				}

			return moleculeView.value!
		}

		// MARK: - Navigation bar items
		
		var toggleModelButton: some SwiftUI.View {
			Button(
				action: {
					viewModel.toggleMoleculeModel()
				},
				label: {
					switch viewModel.moleculeModel {
					case .ballAndStick:
						Image("MoleculePage:BallAndStickModel")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(height: 26)
							.colorMultiply(.blue)
					case .spaceFilling:
						Image("MoleculePage:SpaceFillingModel")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(height: 26)
							.colorMultiply(.blue)
					}
				}
			)
		}

		var shareButton: some SwiftUI.View {
			Button(
				action: {
					if moleculeView.value != nil {
						ImageSharingService.share(image: moleculeView.value!.makeSnapshot())
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

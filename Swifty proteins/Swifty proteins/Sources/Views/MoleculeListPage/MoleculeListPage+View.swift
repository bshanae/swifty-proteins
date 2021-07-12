import SwiftUI

struct MoleculeListPage {
	struct View: SwiftUI.View {
		private static let elementSize = CGFloat(80)
		
		@StateObject private var viewModel = ViewModel()
		
		public var body: some SwiftUI.View {
			ZStack {
				NavigationView {
					ScrollView {
						VStack {
							searchField
							grid
						}
						.ignoresSafeArea()
						.padding(10)
					}
					.navigationBarTitle("Proteins")
				}

				if viewModel.error != nil {
					errorMessage
				}
			}
		}

		private var errorMessage: some SwiftUI.View {
			ZStack {
				Rectangle()
					.foregroundColor(Color(white: 0, opacity: 0))
					.background(Blur(style: .systemUltraThinMaterial))
					.cornerRadius(25)
				
				VStack {
					Spacer()
					errorIcon
					Spacer()
					
					Text("Error")
						.font(.title2)
						.foregroundColor(Assets.textColor)
				}
				.padding(20)
			}
			.frame(width: 200, height: 200)
		}

		private var errorIcon: some SwiftUI.View {
			let uiImage = UIImage(systemName: "xmark.octagon")!
				.scalePreservingAspectRatio(targetSize: CGSize(width: 100, height: 100))
			
			return Image(uiImage: uiImage)
				.renderingMode(.template)
				.foregroundColor(Assets.MoleculeListPage.errorIconColor)
		}
		
		private var searchField: some SwiftUI.View {
			TextField("Filter", text: $viewModel.filter)
				.disableAutocorrection(true)
				.autocapitalization(.none)
				.padding(7)
				.font(.subheadline)
				.background(Assets.MoleculeListPage.searchFieldColor)
				.cornerRadius(8)
		}
		
		private var grid: some SwiftUI.View {
			let columns = [ GridItem(.adaptive(minimum: View.elementSize)) ]
			
			return LazyVGrid(columns: columns, spacing: 10) {
				ForEach(viewModel.moleculeIds, id: \.self) { moleculeId in
					NavigationLink(
						destination: makeMoleculePage(id: moleculeId),
						tag: moleculeId,
						selection: $viewModel.loadedMoleculeId,
						label: { makeMoleculeLabel(moleculeId: moleculeId) }
					)
					.disabled(isMoleculeloading(moleculeId: moleculeId))
				}
			}
		}

		private func isMoleculeloading(moleculeId: String) -> Bool {
			viewModel.requestedMoleculeId == moleculeId
		}
		
		private func makeMoleculeLabel(moleculeId: String) -> some SwiftUI.View {
			ZStack {
				RoundedRectangle(cornerRadius: 5)
					.stroke(Assets.accentColor.opacity(0.5), lineWidth: 1)
					.background(Assets.MoleculeListPage.elementColor)
				
				if isMoleculeloading(moleculeId: moleculeId) {
					ProgressView()
						.scaleEffect(1.2, anchor: .center)
				} else {
					Button(action: { viewModel.requestMolecule(withId: moleculeId) }) {
						Text(moleculeId)
							.font(.title2)
							.foregroundColor(Assets.accentColor)
							.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
							.aspectRatio(1, contentMode: .fit)
							.cornerRadius(5)
					}
					
				}
			}
		}
		
		private func makeMoleculePage(id: String) -> some SwiftUI.View {
			LazyView {
				MoleculePage.View(ofMolecule: viewModel.loadedMolecule!)
			}
		}
	}
}

struct MoleculeListPage_Previews: PreviewProvider {
	static var previews: some View {
		MoleculeListPage.View().preferredColorScheme(.light)
		MoleculeListPage.View().preferredColorScheme(.dark)
	}
}

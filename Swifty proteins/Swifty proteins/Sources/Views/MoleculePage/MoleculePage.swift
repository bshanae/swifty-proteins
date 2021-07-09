import SwiftUI

// Temprory
struct MoleculePage {
	public class ViewModel: ObservableObject {
	}
}

extension MoleculePage {
	public struct View: SwiftUI.View {
		@StateObject private var moleculeRequest: MoleculeRequest = MoleculeService.requestMolecule(ofMolecule: "001")
		
		@StateObject private var viewModel = ViewModel()
		@State private var selectedAtom: Atom?
		
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
			.navigationBarTitle(Text("Hello"), displayMode: .inline)
			.navigationBarItems(trailing: shareButton)
		}
		
		var moleculeView: some SwiftUI.View {
			switch moleculeRequest.status {
			case .success(let molecule):
				let view = MoleculeView(from: molecule)
					.backgroundColor(Assets.MoleculePage.BackgroundColor)
					.onAtomSelected{ selectedAtom in
						self.selectedAtom = selectedAtom
					}
					.ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
				
				return AnyView(view)

			default:
				return AnyView(EmptyView())
			}
		}
		
		var shareButton: some SwiftUI.View {
			Button(action: {}) {
				Image(systemName: "square.and.arrow.up")
			}
		}
		
		var messageAboutSelectedAtom: some SwiftUI.View {
			Text("\(selectedAtom?.kind.name ?? "?")")
				.font(.title)
				.padding(.vertical, 12)
				.padding(.horizontal, 16)
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

struct MoleculePage_Previews: PreviewProvider {
	static var previews: some SwiftUI.View {
		MoleculePage.View().preferredColorScheme(.light)
		MoleculePage.View().preferredColorScheme(.dark)
	}
}

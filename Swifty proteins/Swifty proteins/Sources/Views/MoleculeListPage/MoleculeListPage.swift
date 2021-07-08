import SwiftUI

struct MoleculeListPage: View {
	static let elementSize = CGFloat(90)
	
	@State var filter = ""
	
	var body: some View {
		NavigationView {
			ScrollView(showsIndicators: false) {
				VStack {
					searchField
					grid
				}
				.ignoresSafeArea()
				.padding(10)
			}
			.navigationBarTitle("Proteins")
		}
	}
	
	var searchField: some View {
		TextField("Filter", text: $filter)
			.padding(7)
			.font(.title2)
			.background(Assets.MoleculeListPage.searchFieldColor)
			.cornerRadius(8)
	}
	
	private var columns = [ GridItem(.adaptive(minimum: elementSize)) ]
	
	var grid: some View {
		LazyVGrid(columns: columns, spacing: 10) {
			ForEach(elements.indices) { index in
				NavigationLink(
					destination: makeMoleculePage(id: elements[index])
				) {
					makeElement(text: elements[index])
				}
			}
		}
	}
	
	var elements: [String] {
		(1...50)
			.map{ "0\($0)" }
			.filter{ filter.isEmpty || $0.contains(filter) }
	}
	
	func makeElement(text: String) -> some View {
		Text(text)
			.font(.title)
			.foregroundColor(Assets.accentColor)
			.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
			.background(Assets.MoleculeListPage.elementColor)
			.aspectRatio(1, contentMode: .fit)
			.cornerRadius(5)
			.overlay(
				RoundedRectangle(cornerRadius: 5)
					.stroke(Assets.accentColor.opacity(0.5), lineWidth: 1)
			)
	}
	
	func makeMoleculePage(id: String) -> some View {
		MoleculePage.View()
	}
}

struct MoleculeListPage_Previews: PreviewProvider {
	static var previews: some View {
		MoleculeListPage().preferredColorScheme(.light)
		MoleculeListPage().preferredColorScheme(.dark)
	}
}

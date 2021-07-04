import SwiftUI

struct MoleculeSearchBar: View {
	@Binding private var text: String
	private var onCommit: (String) -> ()
	
	public init(text: Binding<String>) {
		self.init(text: text, onCommit: { _ in })
	}

	private init(
		text: Binding<String>,
		onCommit: @escaping (String) -> () = { _ in }
	) {
		self._text = text
		self.onCommit = onCommit
	}

	public func onCommit(onCommit: @escaping (String) -> ()) -> MoleculeSearchBar {
		MoleculeSearchBar(text: self.$text, onCommit: onCommit)
	}

    public var body: some View {
		TextField("", text: $text, onCommit: { onCommit(text) })
			.disableAutocorrection(true)
			.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
			.accentColor(.white)
			.foregroundColor(.white)
			.padding()
			.frame(width: 180, height: 50)
			.overlay(magnifyingGlass)
    }

	private var magnifyingGlass: some View {
		Image(systemName: "magnifyingglass")
			.foregroundColor(.gray)
			.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
			.padding(.leading, 8)
	}
}

struct MoleculeSearchBar_Previews: PreviewProvider {
    static var previews: some View {
		MoleculeSearchBar(text: .constant("Hello"))
    }
}

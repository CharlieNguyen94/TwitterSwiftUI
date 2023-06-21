import SwiftUI

struct SearchBar: View {
	@Binding var text: String

    var body: some View {
		HStack {
			TextField("Search...", text: $text)
				.padding(8)
				.padding(.horizontal, 28)
				.background(Color(.systemGray6))
				.cornerRadius(8)
				.overlay {
					HStack {
						Image(systemName: "magnifyingglass")
							.foregroundColor(.gray)
							.frame(maxWidth: .infinity, alignment: .leading)
							.padding(.horizontal, 8)
					}
				}
		}
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
		SearchBar(text: .constant(""))
			.previewLayout(.sizeThatFits)
    }
}

import SwiftUI

struct AuthHeaderView: View {
	let title: String
	let subtitle: String

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Spacer()
			}
			Text(title)
				.font(.largeTitle)
				.fontWeight(.semibold)

			Text(subtitle)
				.font(.largeTitle)
				.fontWeight(.semibold)
		}
		.frame(height: 260)
		.padding(.leading)
		.background(.blue)
		.foregroundColor(.white)
		.clipShape(RoundedShape(corners: .bottomRight))
	}
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
		AuthHeaderView(title: "Hello", subtitle: "Welcome back")
    }
}

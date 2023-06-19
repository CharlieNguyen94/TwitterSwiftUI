import SwiftUI

struct NewTweetView: View {
	@Environment(\.dismiss) var dismiss
	@State private var text = ""

	var body: some View {
		VStack {
			HStack {
				Button {
					dismiss()
				} label: {
					Text("Cancel")
						.foregroundColor(.blue)
				}

				Spacer()

				Button {

				} label: {
					Text("Tweet")
						.bold()
						.padding(.horizontal)
						.padding(.vertical, 8)
						.background(.blue)
						.foregroundColor(.white)
						.clipShape(Capsule())
				}
			}
			.padding()

			HStack(alignment: .top) {
				Circle()
					.frame(width: 64, height: 64)

				TextField("What's happening?", text: $text, axis: .vertical)
					.padding(4)
			}
			.padding()

			Spacer()
		}
	}
}

struct NewTweetView_Previews: PreviewProvider {
	static var previews: some View {
		NewTweetView()
	}
}

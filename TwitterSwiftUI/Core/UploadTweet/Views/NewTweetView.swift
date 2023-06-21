import SwiftUI

struct NewTweetView: View {
	@EnvironmentObject var authViewModel: AuthViewModel
	@Environment(\.dismiss) var dismiss
	@State private var text = ""
	@ObservedObject var viewModel = UploadTweetViewModel()


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
					Task {
						try await viewModel.uploadTweet(withCaption: text)
					}
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
				if let user = authViewModel.currentUser {
					ProfileImageView(profileImageUrl: user.profileImageUrl, size: .medium)
				}

				TextField("What's happening?", text: $text, axis: .vertical)
					.padding(4)
			}
			.padding()

			Spacer()
		}
		.onReceive(viewModel.$didUploadTweet) { success in
			if success {
				dismiss()
			}
		}
	}
}

struct NewTweetView_Previews: PreviewProvider {
	static var previews: some View {
		NewTweetView()
	}
}

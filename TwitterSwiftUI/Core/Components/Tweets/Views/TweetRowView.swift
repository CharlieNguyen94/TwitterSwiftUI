import SwiftUI
import Firebase

struct TweetRowView: View {
	@ObservedObject var viewModel: TweetRowViewModel

	init(tweet: Tweet) {
		self.viewModel = TweetRowViewModel(tweet: tweet)
	}

	var body: some View {
		VStack(alignment: .leading) {

			// profile image + user info + tweet
			if let user = viewModel.tweet.user {
				HStack(alignment: .top, spacing: 12) {
					ProfileImageView(profileImageUrl: user.profileImageUrl, size: .medium)

					// User info & Tweet caption
					VStack(alignment: .leading, spacing: 4) {
						HStack {
							Text(user.fullname)
								.font(.subheadline.bold())

							Text("@\(user.username)")
								.foregroundColor(.gray)
								.font(.caption)

							Text("2w")
								.foregroundColor(.gray)
								.font(.caption)
						}
						// tweet caption

						Text(viewModel.tweet.caption)
							.font(.subheadline)
							.multilineTextAlignment(.leading)

					}
				}
			}

			// action buttons
			HStack {
				Button {

				} label: {
					Image(systemName: "bubble.left")
						.font(.subheadline)

				}

				Spacer()

				Button {

				} label: {
					Image(systemName: "arrow.2.squarepath")
						.font(.subheadline)

				}

				Spacer()

				Button {
					Task {
						viewModel.tweet.didLike ?? false ?
						try await viewModel.unlikeTweet() :
						try await viewModel.likeTweet()
					}
				} label: {
					Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
						.font(.subheadline)
						.foregroundColor(viewModel.tweet.didLike ?? false ? .red : .gray)
				}

				Spacer()

				Button {

				} label: {
					Image(systemName: "bookmark")
						.font(.subheadline)

				}
			}
			.padding()
			.foregroundColor(.gray)

			Divider()

		}
		.onAppear {
			Task {
				try await viewModel.checkIfUserLikedTweet()
			}
		}
	}
}

struct TweetRowView_Previews: PreviewProvider {
	static var previews: some View {
		TweetRowView(tweet: Tweet(id: "", uid: "", caption: "", likes: 0, timestamp: Timestamp(date: Date())))
	}
}

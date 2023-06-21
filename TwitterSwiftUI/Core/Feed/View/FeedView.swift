import SwiftUI

struct FeedView: View {
	@State private var showNewTweetView = false
	@ObservedObject var viewModel = FeedViewModel()

	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			ScrollView {
				LazyVStack {
					ForEach(viewModel.tweets, id: \.self) { tweet in
						TweetRowView(tweet: tweet)
							.padding()
					}
				}
			}

			Button {
				showNewTweetView.toggle()
			} label: {
				Image("tweet")
					.resizable()
					.renderingMode(.template)
					.foregroundColor(.white)
					.frame(width: 44, height: 44)
					.background(.blue)
					.clipShape(Circle())
					.padding()
			}
			.fullScreenCover(isPresented: $showNewTweetView) {
				NewTweetView()
			}
		}
		.onAppear {
			Task {
				try await viewModel.fetchTweets()
			}
		}
	}
}

struct FeedView_Previews: PreviewProvider {
	static var previews: some View {
		FeedView()
	}
}

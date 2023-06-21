import Foundation

class FeedViewModel: ObservableObject {
	@Published var tweets = [Tweet]()

	@MainActor
	func fetchTweets() async throws {
		tweets = try await TweetService.fetchTweets()

		for i in 0..<tweets.count {
			let id = tweets[i].id
			Task {
				let user = try await UserService.fetchUser(withId: id)
				tweets[i].user = user
			}
		}
	}
}

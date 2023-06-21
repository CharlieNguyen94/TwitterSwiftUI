import Foundation

class ProfileViewModel: ObservableObject {
	@Published var tweets = [Tweet]()
	@Published var likedTweets = [Tweet]()
	let user: User

	init(user: User) {
		self.user = user
	}

	func tweets(forFiler filter: TweetFilterViewModel) -> [Tweet] {
		switch filter {
		case .tweets:
			return tweets
		case .replies:
			return tweets
		case .likes:
			return likedTweets
		}
	}

	@MainActor
	func fetchUserTweets() async throws {
		guard let id = user.id else { return }
		tweets = try await TweetService.fetchTweets(forId: id)

		for i in 0..<tweets.count {
			tweets[i].user = user
		}
	}

	@MainActor
	func fetchLikedTweets() async throws {
		guard let id = user.id else { return }
		likedTweets = try await TweetService.fetchLikesTweets(forId: id)

		for i in 0..<likedTweets.count {
			let id = likedTweets[i].uid

			let user = try await UserService.fetchUser(withId: id)
			likedTweets[i].user = user
		}
	}
}

import Foundation

class TweetRowViewModel: ObservableObject {
	@Published var tweet: Tweet

	init(tweet: Tweet) {
		self.tweet = tweet
	}

	@MainActor
	func likeTweet() async throws {
		try await TweetService.likeTweet(tweet)
		tweet.didLike = true
	}

	@MainActor
	func unlikeTweet() async throws {
		try await TweetService.unlikeTweet(tweet)
		tweet.didLike = false
	}

	@MainActor
	func checkIfUserLikedTweet() async throws {
		let didLike = try await TweetService.checkIfUserLikedTweet(tweet)
		if didLike {
			tweet.didLike = true
		}
	}
}

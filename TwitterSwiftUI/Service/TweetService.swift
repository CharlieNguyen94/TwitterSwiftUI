import Firebase

struct TweetService {

	static func uploadTweet(caption: String) async throws {
		guard let id = Auth.auth().currentUser?.uid else { return }

		let tweet = Tweet(
			id: id,
			caption: caption,
			likes: 0,
			timestamp: Timestamp(date: Date())
		)
		guard let encodedTweet = try? Firestore.Encoder().encode(tweet) else { return }

		try await Firestore.firestore().collection("tweets")
			.document().setData(encodedTweet)
	}

	static func fetchTweets() async throws -> [Tweet] {
		let snapshot = try await Firestore.firestore().collection("tweets").getDocuments()
		let documents = snapshot.documents

		let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
		return tweets
	}
}

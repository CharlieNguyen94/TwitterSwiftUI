import Firebase

struct TweetService {

	private static let tweetCollection = Firestore.firestore().collection("tweets")
	private static let usersCollection = Firestore.firestore().collection("users")

	static func uploadTweet(caption: String) async throws {
		guard let id = Auth.auth().currentUser?.uid else { return }

		let tweet = Tweet(
			id: nil,
			uid: id,
			caption: caption,
			likes: 0,
			timestamp: Timestamp(date: Date())
		)
		guard let encodedTweet = try? Firestore.Encoder().encode(tweet) else { return }

		try await tweetCollection
			.document().setData(encodedTweet)
	}

	static func fetchTweets() async throws -> [Tweet] {
		let snapshot = try await tweetCollection
			.order(by: "timestamp", descending: true)
			.getDocuments()
		let documents = snapshot.documents

		let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
		return tweets
	}

	static func fetchTweets(forId id: String) async throws -> [Tweet] {
		let snapshot = try await tweetCollection
			.whereField("uid", isEqualTo: id)
			.getDocuments()
		let documents = snapshot.documents

		let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
		return tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
	}
}

//MARK: - Likes

extension TweetService {
	static func likeTweet(_ tweet: Tweet) async throws {
		guard let id = Auth.auth().currentUser?.uid,
			  let tweetId = tweet.id else { return }


		let userLikesRef = usersCollection
			.document(id)
			.collection("user-likes")

		try await tweetCollection.document(tweetId)
			.updateData(["likes": tweet.likes + 1])

		try await userLikesRef.document(tweetId)
			.setData([:])
	}

	static func checkIfUserLikedTweet(_ tweet: Tweet) async throws -> Bool {
		guard let id = Auth.auth().currentUser?.uid,
			  let tweetId = tweet.id else { return false }
		let snapshot = try await usersCollection.document(id).collection("user-likes").document(tweetId).getDocument()
		return snapshot.exists
	}

	static func unlikeTweet(_ tweet: Tweet) async throws {
		guard let id = Auth.auth().currentUser?.uid,
			  let tweetId = tweet.id,
			  tweet.likes > 0 else { return }

		let userLikesRef = usersCollection
			.document(id)
			.collection("user-likes")

		try await tweetCollection.document(tweetId)
			.updateData(["likes": tweet.likes - 1])

		try await userLikesRef.document(tweetId)
			.delete()
	}

	static func fetchLikesTweets(forId id: String) async throws -> [Tweet] {
		var tweets = [Tweet]()

		let snapshot = try await usersCollection
			.document(id)
			.collection("user-likes")
			.getDocuments()

		let documents = snapshot.documents

		try await documents.asyncForEach { doc in
			let tweetId = doc.documentID
			let snapshot = try await tweetCollection
				.document(tweetId)
				.getDocument()
			guard let tweet = try? snapshot.data(as: Tweet.self) else { return }
			tweets.append(tweet)
		}
		return tweets
	}
}

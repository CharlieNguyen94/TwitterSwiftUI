import Foundation

class UploadTweetViewModel: ObservableObject {

	@Published var didUploadTweet = false

	@MainActor
	func uploadTweet(withCaption caption: String) async throws {
		do {
			try await TweetService.uploadTweet(caption: caption)
			self.didUploadTweet = true
		} catch {
			print(error.localizedDescription)
		}
	}
}

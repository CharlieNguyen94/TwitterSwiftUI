import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Tweet: Identifiable, Hashable, Codable {
	@DocumentID var id: String?
	let uid: String
	let caption: String
	var likes: Int
	let timestamp: Timestamp
	var user: User?
	var didLike: Bool? = false
}

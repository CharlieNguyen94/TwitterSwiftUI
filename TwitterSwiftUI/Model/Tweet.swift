import Foundation
import Firebase

struct Tweet: Identifiable, Hashable, Codable {
	let id: String
	let caption: String
	var likes: Int
	let timestamp: Timestamp
	var user: User?
}

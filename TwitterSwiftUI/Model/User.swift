import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Codable, Hashable {
	@DocumentID var id: String?
	let email: String
	let fullname: String
	let username: String
	let profileImageUrl: String?

	var isCurrentUser: Bool {
		return Auth.auth().currentUser?.uid == id
	}
}

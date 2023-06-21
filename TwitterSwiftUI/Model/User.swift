import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Hashable {
	@DocumentID var id: String?
	let email: String
	let fullname: String
	let username: String
	let profileImageUrl: String?
}

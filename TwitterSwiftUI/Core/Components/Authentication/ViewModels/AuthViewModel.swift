import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import PhotosUI

class AuthViewModel: ObservableObject {
	@Published var userSession: FirebaseAuth.User?
	@Published var currentUser: User?
	@Published var didAuthenticateUser = false
	@Published var selectedImage: PhotosPickerItem? {
		didSet { Task { await loadImage(fromItem: selectedImage) }}
	}
	@Published var profileImage: Image?
	private var uiImage: UIImage?
	private var tempUserSession: FirebaseAuth.User?

	init() {
		self.userSession = Auth.auth().currentUser
	}

	@MainActor
	func loadImage(fromItem item: PhotosPickerItem?) async {
		guard let item = item,
			  let data = try? await item.loadTransferable(type: Data.self),
			  let uiImage = UIImage(data: data) else { return }
		self.uiImage = uiImage
		self.profileImage = Image(uiImage: uiImage)
	}

	@MainActor
	func login(withEmail email: String, password: String) async throws {
		do {
			let result = try await Auth.auth().signIn(withEmail: email, password: password)
			self.userSession = result.user
		} catch {
			print(error.localizedDescription)
		}
	}

	func signOut() {
		try? Auth.auth().signOut()
		self.userSession = nil
		self.currentUser = nil
	}

	@MainActor
	func register(withEmail email: String, password: String, fullname: String, username: String) async throws {
		do {
			let result = try await Auth.auth().createUser(withEmail: email, password: password)
			self.tempUserSession = result.user
			await uploadUserData(id: result.user.uid, email: email, fullname: fullname, username: username)
		} catch {
			print("Failed to register with error \(error.localizedDescription)")
		}
	}

	@MainActor
	private func uploadUserData(id: String, email: String, fullname: String, username: String) async {
		let user = User(id: id, email: email, fullname: fullname, username: username.lowercased(), profileImageUrl: nil)
		self.currentUser = user
		guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
		try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
		self.didAuthenticateUser = true
	}

	@MainActor
	func uploadProfileImage() {
		guard let uid = tempUserSession?.uid,
			  let image = uiImage else { return }

		Task {
			var data = [String: Any]()
			let imageUrl = try? await ImageUploader.uploadImage(image: image)
			data["profileImageUrl"] = imageUrl

			if !data.isEmpty {
				try await Firestore.firestore().collection("users")
					.document(uid)
					.updateData(data)
			}
			self.userSession = self.tempUserSession
		}
	}
}

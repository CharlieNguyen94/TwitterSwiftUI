import Foundation

class ExploreViewModel: ObservableObject {
	@Published var users = [User]()

	@MainActor
	func fetchUsers() async throws {
		self.users = try await UserService.fetchAllUsers()
	}
}

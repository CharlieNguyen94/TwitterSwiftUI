import Foundation

class ExploreViewModel: ObservableObject {
	@Published var users = [User]()
	@Published var searchText = ""

	var searchableUsers: [User] {
		if searchText.isEmpty {
			return users
		} else {
			let lowercasedQuery = searchText.lowercased()

			return users.filter {
				$0.username.contains(lowercasedQuery) ||
				$0.fullname.lowercased().contains(lowercasedQuery)
			}
		}
	}

	@MainActor
	func fetchUsers() async throws {
		self.users = try await UserService.fetchAllUsers()
	}
}

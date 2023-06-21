import SwiftUI

struct ExploreView: View {
	@ObservedObject var viewModel = ExploreViewModel()

	var body: some View {
		VStack {
			ScrollView {
				LazyVStack {
					ForEach(viewModel.users, id: \.id) { user in
						NavigationLink {
							ProfileView(user: user)
						} label: {
							UserRowView(user: user)
						}
					}
				}
			}
		}
		.onAppear {
			Task {
				try await viewModel.fetchUsers()
			}
		}
		.navigationTitle("Explore")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct ExploreView_Previews: PreviewProvider {
	static var previews: some View {
		ExploreView()
	}
}

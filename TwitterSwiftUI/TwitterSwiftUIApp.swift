import SwiftUI
import Firebase

@main
struct TwitterSwiftUIApp: App {

	@StateObject var viewModel = AuthViewModel()

	init() {
		FirebaseApp.configure()
	}

    var body: some Scene {
		WindowGroup {
			NavigationStack {
				ContentView()
			}
			.environmentObject(viewModel)
		}
	}
}

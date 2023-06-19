import SwiftUI
import Firebase

@main
struct TwitterSwiftUIApp: App {

	init() {
		FirebaseApp.configure()
	}

    var body: some Scene {
		WindowGroup {
			NavigationStack {
				LoginView()
			}
		}
	}
}

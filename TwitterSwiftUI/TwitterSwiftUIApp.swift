import SwiftUI

@main
struct TwitterSwiftUIApp: App {
    var body: some Scene {
		WindowGroup {
			NavigationStack {
				LoginView()
			}
		}
	}
}

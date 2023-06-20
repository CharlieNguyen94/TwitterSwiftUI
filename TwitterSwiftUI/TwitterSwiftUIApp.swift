import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		return true
	}
}

@main
struct TwitterSwiftUIApp: App {

	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	@StateObject var viewModel = AuthViewModel()

    var body: some Scene {
		WindowGroup {
			NavigationView {
				ContentView()
			}
			.environmentObject(viewModel)
		}
	}
}

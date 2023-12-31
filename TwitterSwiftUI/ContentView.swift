import SwiftUI
import Kingfisher

struct ContentView: View {
	@State private var showMenu = false
	@EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
		Group {
			if viewModel.userSession == nil {
				LoginView()
			} else {
				mainInterfaceView
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
	var mainInterfaceView: some View {
		ZStack(alignment: .topLeading) {
			MainTabView()
				.navigationBarHidden(showMenu)

			if showMenu {
				ZStack {
					Color(.black)
						.opacity(showMenu ? 0.25 : 0)
				}
				.onTapGesture {
					withAnimation(.easeInOut){
						showMenu = false
					}
				}
				.ignoresSafeArea()
			}

			SideMenuView()
				.frame(width: 300)
				.offset(x: showMenu ? 0 : -300)
				.background(showMenu ? .white : .clear)
		}
		.navigationTitle("Home")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				if let user = viewModel.currentUser {
					Button {
						withAnimation(.easeInOut) {
							showMenu.toggle()
						}
					} label: {
						ProfileImageView(profileImageUrl: user.profileImageUrl, size: .small)
					}
				}
			}
		}
		.onAppear {
			showMenu = false
		}
	}
}

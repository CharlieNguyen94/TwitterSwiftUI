import SwiftUI
import PhotosUI

struct ProfilePhotoSelectorView: View {
	@EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
		VStack {
			AuthHeaderView(title: "Create your account", subtitle: "Select a profile photo")

			PhotosPicker(selection: $viewModel.selectedImage) {
				if viewModel.selectedImage == nil {
					Image("addPhoto")
						.resizable()
						.renderingMode(.template)
						.foregroundColor(.blue)
						.scaledToFill()
						.frame(width: 180, height: 180)
				} else {
					viewModel.profileImage?
						.resizable()
						.scaledToFill()
						.frame(width: 180, height: 180)
						.clipShape(Circle())
				}
			}
			.padding(.top, 44)

			if viewModel.selectedImage != nil {
				AuthButton(title: "Continue") {
					viewModel.uploadProfileImage()
				}
			}

			Spacer()
		}
		.ignoresSafeArea()
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}

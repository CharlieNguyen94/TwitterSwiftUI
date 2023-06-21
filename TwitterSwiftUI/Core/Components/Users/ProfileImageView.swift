import SwiftUI
import Kingfisher

enum ProfileImageSize {
	case small
	case medium
	case large

	var dimension: CGFloat {
		switch self {
		case .small:
			return 32
		case .medium:
			return 48
		case .large:
			return 72
		}
	}
}

struct ProfileImageView: View {

	let profileImageUrl: String?
	let size: ProfileImageSize

    var body: some View {
		KFImage(URL(string: profileImageUrl ?? ""))
			.resizable()
			.scaledToFill()
			.clipShape(Circle())
			.frame(width: size.dimension, height: size.dimension)
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
		ProfileImageView(profileImageUrl: "", size: .small)
    }
}

import SwiftUI

struct UserRowView: View {
	let user: User

	var body: some View {
		HStack(spacing: 12) {
			ProfileImageView(profileImageUrl: user.profileImageUrl, size: .medium)

			VStack(alignment: .leading, spacing: 4) {
				Text(user.username)
					.font(.subheadline.bold())
					.foregroundColor(.black)

				Text(user.fullname)
					.font(.subheadline)
					.foregroundColor(.gray)
			}

			Spacer()
		}
		.padding(.horizontal)
		.padding(.vertical, 4)
	}
}

struct UserRowView_Previews: PreviewProvider {
	static var previews: some View {
		UserRowView(user: User(id: "", email: "", fullname: "", username: "", profileImageUrl: ""))
	}
}

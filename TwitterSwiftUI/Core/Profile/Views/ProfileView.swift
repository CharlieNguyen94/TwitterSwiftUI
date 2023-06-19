import SwiftUI

struct ProfileView: View {
	@State private var selectedFilter: TweetFilterViewModel = .tweets
	@Namespace var animation

    var body: some View {
		VStack(alignment: .leading) {
			headerView
			actionButtons
			userInfoDetails
			tweetFilterBar
			tweetsView

			Spacer()
		}
		.ignoresSafeArea(edges: .bottom)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
	var headerView: some View {
		ZStack(alignment: .bottomLeading) {
			Color(.systemBlue)
				.ignoresSafeArea()

			VStack {
				Button {

				} label: {
					Image(systemName: "arrow.left")
						.resizable()
						.frame(width: 20, height: 16)
						.foregroundColor(.white)
						.offset(x: 16, y: 24)
				}

				Circle()
					.frame(width: 72, height: 72)
				.offset(x: 16, y: 28)
			}
		}
		.frame(height: 96)
	}

	var actionButtons: some View {
		HStack(spacing: 12) {
			Spacer()

			Image(systemName: "bell.badge")
				.font(.title3)
				.padding(6)
				.overlay(Circle().stroke(.gray, lineWidth: 0.75))

			Button {

			} label: {
				Text("Edit Profile")
					.font(.subheadline.bold())
					.frame(width: 120, height: 32)
					.overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.75))
			}

		}
		.padding(.trailing)
	}

	var userInfoDetails: some View {
		VStack(alignment: .leading, spacing: 4) {
			HStack {
				Text("Heath Ledger")
					.font(.title2.bold())

				Image(systemName: "checkmark.seal.fill")
					.foregroundColor(.blue)
			}

			Text("@joker")
				.font(.subheadline)
				.foregroundColor(.gray)

			Text("Your mom favorite villain")
				.font(.subheadline)
				.padding(.vertical)

			HStack(spacing: 24) {
				HStack {
					Image(systemName: "mappin.and.ellipse")

					Text("Gotham, NY")
				}

				HStack {
					Image(systemName: "link")

					Text("www.thejoker.com")
				}
			}
			.font(.caption)
			.foregroundColor(.gray)

			HStack(spacing: 24) {
				HStack(spacing: 4) {
					Text("807")
						.font(.subheadline)
						.bold()

					Text("Following")
						.font(.caption)
						.foregroundColor(.gray)

				}

				HStack(spacing: 4) {
					Text("6.9M")
						.font(.subheadline)
						.bold()

					Text("Followers")
						.font(.caption)
						.foregroundColor(.gray)

				}
			}
			.padding(.vertical)
		}
		.padding(.horizontal)
	}

	var tweetFilterBar: some View {
		HStack {
			ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
				VStack {
					Text(item.title)
						.font(.subheadline)
						.fontWeight(selectedFilter == item ? .semibold : .regular)
						.foregroundColor(selectedFilter == item ? .black : .gray)

					if selectedFilter == item {
						Capsule()
							.foregroundColor(.blue)
							.frame(height: 3)
							.matchedGeometryEffect(id: "filter", in: animation)
					} else {
						Capsule()
							.foregroundColor(.clear)
							.frame(height: 3)
					}
				}
				.onTapGesture {
					withAnimation(.easeInOut) {
						self.selectedFilter = item
					}
				}
			}
		}
		.overlay(Divider().offset(x: 0, y: 16))
	}

	var tweetsView: some View {
		ScrollView {
			LazyVStack {
				ForEach(0...9, id: \.self) { _ in
					TweetRowView()
						.padding()
				}
			}
		}
	}
}

import SwiftUI

struct FeedView: View {
	@State private var showNewTweetView = false

	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			ScrollView {
				LazyVStack {
					ForEach(0...20, id: \.self) { _ in
						TweetRowView()
							.padding()
					}
				}
			}

			Button {
				showNewTweetView.toggle()
			} label: {
				Image("tweet")
					.resizable()
					.renderingMode(.template)
					.foregroundColor(.white)
					.frame(width: 44, height: 44)
					.background(.blue)
					.clipShape(Circle())
					.padding()
			}
			.fullScreenCover(isPresented: $showNewTweetView) {
				NewTweetView()
			}
		}
	}
}

struct FeedView_Previews: PreviewProvider {
	static var previews: some View {
		FeedView()
	}
}

import SwiftUI

struct AuthButton: View {
	let title: String
	let completion: () -> Void
	
    var body: some View {
		Button {
			completion()
		} label: {
			Text(title)
				.font(.headline)
				.foregroundColor(.white)
				.frame(width: 340, height: 50)
				.background(.blue)
				.clipShape(Capsule())
				.padding()
		}
		.shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}

struct SignUpButton_Previews: PreviewProvider {
    static var previews: some View {
		AuthButton(title: "Sign In") {}
    }
}

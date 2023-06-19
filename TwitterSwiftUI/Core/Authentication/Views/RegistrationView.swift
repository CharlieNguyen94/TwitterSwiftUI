import SwiftUI

struct RegistrationView: View {
	@EnvironmentObject var viewModel: AuthViewModel
	@Environment(\.dismiss) var dismiss
	@State private var email = ""
	@State private var username = ""
	@State private var fullname = ""
	@State private var password = ""

	var body: some View {
		VStack {
			AuthHeaderView(title: "Get Started.", subtitle: "Create your account")

			VStack(spacing: 40) {
				CustomInputField(
					imageName: "envelope",
					placeholderText: "Email",
					text: $email
				)
				CustomInputField(
					imageName: "person",
					placeholderText: "Username",
					text: $username
				)
				CustomInputField(
					imageName: "person",
					placeholderText: "Full name",
					text: $fullname
				)
				CustomInputField(
					imageName: "lock",
					placeholderText: "Password",
					text: $password
				)
			}
			.padding(32)

			AuthButton(title: "Sign Up") {
				viewModel.register(
					withEmail: email,
					password: password,
					fullname: fullname,
					username: username
				)
			}

			Spacer()

			Button {
				dismiss()
			} label: {
				HStack {
					Text("Don't have an account?")
						.font(.footnote)

					Text("Sign Up")
						.font(.footnote)
						.fontWeight(.semibold)
				}
			}
			.padding(.bottom, 32)

		}
		.ignoresSafeArea()
	}
}

struct RegistrationView_Previews: PreviewProvider {
	static var previews: some View {
		RegistrationView()
	}
}

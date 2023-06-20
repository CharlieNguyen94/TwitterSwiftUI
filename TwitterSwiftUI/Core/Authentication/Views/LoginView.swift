import SwiftUI

struct LoginView: View {
	@State private var email = ""
	@State private var password = ""
	@EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
		VStack {
			AuthHeaderView(title: "Hello.", subtitle: "Welcome back.")

			VStack(spacing: 40) {
				CustomInputField(
					imageName: "envelope",
					placeholderText: "Email",
					text: $email
				)
				CustomInputField(
					imageName: "lock",
					placeholderText: "Password",
					isSecureField: true,
					text: $password
				)
			}
			.padding(.horizontal, 32)
			.padding(.top, 44)

			HStack {
				Spacer()

				NavigationLink {
					Text("Reset password view...")
				} label: {
					Text("Forgot password?")
						.font(.caption)
						.fontWeight(.semibold)
						.foregroundColor(.blue)
						.padding(.top)
						.padding(.trailing, 24)
				}
			}

			AuthButton(title: "Sign In") {
				Task {
					try await viewModel.login(withEmail: email, password: password)
				}
			}

			Spacer()

			NavigationLink {
				RegistrationView()
					.toolbar(.hidden)
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
			.foregroundColor(.blue)
		}
		.ignoresSafeArea()
		.toolbar(.hidden)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

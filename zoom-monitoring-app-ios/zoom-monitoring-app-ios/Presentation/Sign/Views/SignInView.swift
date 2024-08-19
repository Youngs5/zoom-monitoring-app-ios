//
//  SignInView.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                TextField("ID", text: $viewModel.userId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)

                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 20)
                }

                if let error = viewModel.error {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding(.horizontal, 40)
                }

                if let user = viewModel.user {
                    Text("Welcome, \(user.userId ?? "User")!")
                        .foregroundColor(.green)
                        .padding(.top, 10)
                }

                Button(action: {
                    viewModel.signIn()
                }) {
                    Text("LOGIN")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)

                NavigationLink(destination: {
                    let networkService = DefaultNetworkService()
                    let userRepository = DefaultUserRepository(networkService: networkService)
                    let signUpUseCase = DefaultSignUpUserUseCase(userRepository: userRepository)
                    let signUpViewModel = SignUpViewModel(signUpUserUseCase: signUpUseCase)
                    SignUpView(viewModel: signUpViewModel)
                }) {
                    Text("Sign Up")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding(.top, 10)

                Spacer()
            }
        }
    }
}

#Preview {
    let networkService = DefaultNetworkService()
    let userRepository = DefaultUserRepository(networkService: networkService)
    let signInUseCase = DefaultSignInUserUseCase(userRepository: userRepository)
    let signInViewModel = SignInViewModel(signInUserUseCase: signInUseCase)

    return SignInView(viewModel: signInViewModel)
}

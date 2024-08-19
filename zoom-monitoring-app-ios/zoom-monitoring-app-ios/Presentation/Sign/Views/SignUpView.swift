//
//  SignUpView.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @State private var step = 1
    
    var body: some View {
        VStack {
            ProgressView(value: Double(step), total: 3.0)
                .padding()

            if step == 1 {
                StepOneView(userID: $viewModel.userId, password: $viewModel.password)
            } else if step == 2 {
                StepTwoView(name: $viewModel.userId, phoneNumber: $viewModel.phoneNumber, email: $viewModel.email)
            } else if step == 3 {
                CompletionView()
            }

            Spacer()

            Button(action: {
                if step < 3 {
                    step += 1
                } else {
                    viewModel.signUp()
                }
            }) {
                Text(step < 3 ? "Next" : "Complete Sign Up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(!isStepValid())
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
        }
        .padding()
    }

    private func isStepValid() -> Bool {
        if step == 1 {
            return !viewModel.userId.isEmpty && !viewModel.password.isEmpty
        } else if step == 2 {
            return !viewModel.userId.isEmpty && !viewModel.email.isEmpty && !viewModel.phoneNumber.isEmpty
        }
        return true
    }
}

struct StepOneView: View {
    @Binding var userID: String
    @Binding var password: String

    var body: some View {
        VStack {
            TextField("User ID", text: $userID)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 10)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 10)
        }
    }
}

struct StepTwoView: View {
    @Binding var name: String
    @Binding var phoneNumber: String
    @Binding var email: String

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Phone Number", text: $phoneNumber)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 10)

            TextField("Email", text: $email)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
        }
    }
}

struct CompletionView: View {
    var body: some View {
        VStack {
            Text("Sign Up Complete!")
                .font(.largeTitle)
                .padding()
            Text("Thank you for signing up. You can now use our app.")
                .padding()
        }
    }
}

#Preview {
    let networkService = DefaultNetworkService()
    let userRepository = DefaultUserRepository(networkService: networkService)
    let signUpUseCase = DefaultSignUpUserUseCase(userRepository: userRepository)
    let signUpViewModel = SignUpViewModel(signUpUserUseCase: signUpUseCase)
    
    return SignUpView(viewModel: signUpViewModel)
}

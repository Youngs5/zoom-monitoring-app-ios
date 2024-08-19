//
//  SignUpViewModel.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    private let signUpUserUseCase: SignUpUserUseCase
    
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var errorMessage: String?
    @Published var isSignUpSuccessful: Bool = false
    
    init(signUpUserUseCase: SignUpUserUseCase) {
        self.signUpUserUseCase = signUpUserUseCase
    }
    
    func signUp() {
        let requestValue = SignUpUserUseCaseRequestValue(userId: userId, password: password, email: email, phoneNumber: phoneNumber)
        
        signUpUserUseCase.execute(requestValue: requestValue, cached: {
            // Cache data if necessary
        }, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.isSignUpSuccessful = true
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        })
    }
}

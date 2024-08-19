//
//  SignInViewModel.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    private let signInUserUseCase: SignInUserUseCase
    
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var user: User?
    @Published var error: Error?
    
    private var signInTask: Cancellable?
    
    init(signInUserUseCase: SignInUserUseCase) {
        self.signInUserUseCase = signInUserUseCase
    }
    
    func signIn() {
        isLoading = true
        let requestValue = SignInUserUseCaseRequestValue(userId: userId, password: password)
        
        signInTask = signInUserUseCase.execute(requestValue: requestValue, cached: { [weak self] user in
            self?.user = user
        }, completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.error = error
            }
        })
    }
    
    func cancelSignIn() {
        signInTask?.cancel()
    }
}

//
//  SignInUserUseCase.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import Foundation

protocol Cancellable {
    func cancel()
}

protocol SignInUserUseCase {
    func execute(requestValue: SignInUserUseCaseRequestValue,
                 cached: @escaping (User) -> Void,
                 completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
}

class DefaultSignInUserUseCase: SignInUserUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(requestValue: SignInUserUseCaseRequestValue,
                 cached: @escaping (User) -> Void,
                 completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        return userRepository.signIn(userId: requestValue.userId,
                                     password: requestValue.password,
                                     completion: completion)
    }
}

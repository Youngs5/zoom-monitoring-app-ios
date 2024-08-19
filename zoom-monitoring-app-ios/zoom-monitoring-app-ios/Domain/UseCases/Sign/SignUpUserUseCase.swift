//
//  SignUpUserUseCase.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import Foundation

protocol SignUpUserUseCase {
    func execute(requestValue: SignUpUserUseCaseRequestValue,
                 cached: @escaping () -> Void,
                 completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
}

struct SignUpUserUseCaseRequestValue {
    let userId: String
    let password: String
    let email: String
    let phoneNumber: String
}

class DefaultSignUpUserUseCase: SignUpUserUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(requestValue: SignUpUserUseCaseRequestValue,
                 cached: @escaping () -> Void,
                 completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        return userRepository.signUp(userId: requestValue.userId,
                                     password: requestValue.password,
                                     email: requestValue.email,
                                     phoneNumber: requestValue.phoneNumber,
                                     completion: completion)
    }
}

//
//  UserRepository.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import Foundation

protocol UserRepository {
    func signIn(userId: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
    
    func signUp(userId: String,
                password: String,
                email: String,
                phoneNumber: String,
                completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
}

class DefaultUserRepository: UserRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func signIn(userId: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        let task = networkService.requestSignIn(userId: userId, password: password) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
    
    func signUp(userId: String,
                password: String,
                email: String,
                phoneNumber: String,
                completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        let task = networkService.requestSignUp(userId: userId, password: password, email: email, phoneNumber: phoneNumber) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
}

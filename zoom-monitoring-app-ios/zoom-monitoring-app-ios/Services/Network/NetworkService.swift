//
//  NetworkService.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/18/24.
//

import Foundation

protocol NetworkService {
    func requestSignIn(userId: String,
                       password: String,
                       completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
    
    func requestSignUp(userId: String,
                       password: String,
                       email: String,
                       phoneNumber: String,
                       completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
}

class DefaultNetworkService: NetworkService {
    
    func requestSignIn(userId: String,
                       password: String,
                       completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        // 여기에 실제 네트워크 요청을 수행하는 코드를 작성합니다.
        // 모의 데이터와 네트워크 요청을 시뮬레이션할 수 있습니다.
        
        let mockUser = User(id: UUID().uuidString, userId: userId, userPassword: password)
        completion(.success(mockUser))
        return nil
    }
    
    func requestSignUp(userId: String,
                       password: String,
                       email: String,
                       phoneNumber: String,
                       completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        // 여기에 실제 네트워크 요청을 수행하는 코드를 작성합니다.
        // 모의 데이터와 네트워크 요청을 시뮬레이션할 수 있습니다.
        
        let mockUser = User(id: UUID().uuidString, userId: userId, userPassword: password, phoneNumber: phoneNumber, email: email)
        completion(.success(mockUser))
        return nil
    }
}

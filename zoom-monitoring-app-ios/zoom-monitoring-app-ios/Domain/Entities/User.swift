//
//  User.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import Foundation

struct User: Equatable, Identifiable {
    typealias Identifier = String
    
    var id: Identifier
    var userId: String?
    var userPassword: String?
    var phoneNumber: String?
    var email: String?
    var createdAt: Date?
}

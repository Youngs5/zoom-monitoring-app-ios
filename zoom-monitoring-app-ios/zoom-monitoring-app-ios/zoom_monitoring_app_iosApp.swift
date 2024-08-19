//
//  zoom_monitoring_app_iosApp.swift
//  zoom-monitoring-app-ios
//
//  Created by 오영석 on 8/19/24.
//

import SwiftUI

@main
struct zoom_monitoring_app_iosApp: App {
    
    var body: some Scene {
        WindowGroup {
            let networkService = DefaultNetworkService()
            let userRepository = DefaultUserRepository(networkService: networkService)
            let signInUseCase = DefaultSignInUserUseCase(userRepository: userRepository)
            let signInViewModel = SignInViewModel(signInUserUseCase: signInUseCase)
            
            SignInView(viewModel: signInViewModel)
        }
    }
}

//
//  UserDefaultsConstants.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//


import Foundation

enum UserDefaultConstants {
    case loginToken
 
    
    var value: String {
        switch self {
        case .loginToken: return "usersLoginTokenSavedWhileLogin"
        }
    }
    
}


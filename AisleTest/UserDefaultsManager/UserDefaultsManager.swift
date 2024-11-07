//
//  UserDefaultsManager.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//

import Foundation

final class UserDefaultsManager {
    static func set(value: Any, forKey key: UserDefaultConstants) {
        UserDefaults.standard.setValue(value, forKey: key.value)
        UserDefaults.standard.synchronize()
    }
    

    static var loginToken: String? {
        set {
            set(value: newValue ?? "", forKey: .loginToken)
        } get {
            guard let token = UserDefaults.standard
                .string(forKey: UserDefaultConstants.loginToken.value) else {
                    return nil
            }
            return token == "" ? nil : token
        }
    }
}

//
//  Helper.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//

import UIKit

final class Helper {
    
    static func executeTaskOnMainThread(after delay: Double = 0, task: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { task() }
    }
    
    static let methodToOpenSettings = {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in })
        } else {
            guard UIApplication.shared.openURL(url) else {
                AppDelegate.shared.window?.rootViewController?
                    .showAlertWith(message: .internetError, buttons: .ok(nil))
                return
            }
        }
    }
  
}

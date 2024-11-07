//
//  AletMessages.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//


import UIKit

typealias NullableCompletion = (()->Void)?

enum AlertTitle {
    case appName
    case custom(String?)
    
    var value: String? {
        switch self {
        case .appName: return "Aisle"
        case .custom(let name): return name
        }
    }
}

enum AlertButton {
    case ok(NullableCompletion), cancel, custom(String, NullableCompletion, UIAlertAction.Style)
    , settings
    
    var name: String {
        switch self {
        case .ok: return "Ok"
        case .cancel: return "Cancel"
        case .custom(let value, _, _): return value
        case .settings: return "Settings"
        }
    }
    
    var action: NullableCompletion {
        switch self {
        case .ok(let closure):
            return {
                closure?()
            }
        case .cancel: return nil
        case .custom(_, let closure, _):
            return {
                closure?()
            }
        case .settings: return Helper.methodToOpenSettings
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .cancel: return .cancel
        case .custom(_, _, let style): return style
        default: return .default
        }
    }
}

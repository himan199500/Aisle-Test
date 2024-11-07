//
//  Messages.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//


import Foundation

enum AlertMessages {
    case custom(String?),internetError,emptyNumber,invalidNumber,emptyOtp,invalidOTP
    
    var value: String? {
        switch self {
        case .custom(let string):
            return string?.localized
        case .internetError:
            return "INTERNETERROR".localized
        case .emptyNumber:
            return "EMPTYNUMBER".localized
        case .invalidNumber:
            return "INVALIDNUMBER".localized
        case .emptyOtp:
            return "EMPTYOTP".localized
            
        case .invalidOTP:
            return "INVALIDOTP".localized
        }
    }
}


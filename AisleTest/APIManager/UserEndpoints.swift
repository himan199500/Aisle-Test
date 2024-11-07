
//
//  AppDelegate.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//

import Alamofire

enum UserEndpoint: Endpoint {
    
    case login(Parameters), verifyOtp(Parameters),getUserProfile
    
    var url: String {
        switch self {
        case .login: return "\(base)/users/phone_number_login"
        case .verifyOtp: return "\(base)/users/verify_otp"
        case .getUserProfile: return "\(base)/users/test_profile_list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login,.verifyOtp:
            return .post
        case .getUserProfile:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let params),.verifyOtp(let params):
            return params
        case .getUserProfile:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login, .verifyOtp:
            return URLEncoding.httpBody
        case .getUserProfile:
            return JSONEncoding.default
        }
    }
}

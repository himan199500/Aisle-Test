//
//  AppDelegate.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//

import Alamofire

extension Endpoint {
    private func logRequest(with response: AFDataResponse<Any>) {
        #if DEBUG
        debugPrint("********************************* API Request **************************************")
        debugPrint("Request URL:\(url)")
        debugPrint("Request Parameters: \(parameters ?? [:])")
        debugPrint("Request Headers: \(headers)")
        debugPrint("Request Response ---------->")
        if let data = response.data {
            debugPrint(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")
        } else {
            debugPrint("Invalid response")
        }
        debugPrint("************************************************************************************")
        #endif
    }
    
    /**
     Method to handle the response from server, it is used by the endpoint execute method, and the upload manager
     - parameter response: The AFDataResponse from the server
     - parameter showIndicator: False if you want to interact without the activity indicator
     - parameter completion: A Closure to handle the response from the server
     */
    func handle(
        response: AFDataResponse<Any>,
        withHiddenIndicator showIndicator: Bool,
        withCompletion completion: WebResponseClosure
    ) {
        logRequest(with: response)
        
        switch response.result {
        case .success(let anyValue):
            guard let responseCode = response.response?.statusCode,
                (200..<300).contains(responseCode) else {
                Helper.executeTaskOnMainThread {
                        Indicator.shared.hide()
                        completion?(.failure(self.error(from: anyValue)))
                    }
                    return
            }
            Helper.executeTaskOnMainThread {
                Indicator.shared.hide()
                completion?(.success(anyValue as AnyObject))
            }
        case .failure(let error):
            #if DEBUG
            print(error)
            #endif
            lookoutForHTTPErrors(in: response.response)
        }
    }
}

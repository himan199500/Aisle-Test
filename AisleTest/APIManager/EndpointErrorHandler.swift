
import Alamofire

enum EndpointError: Error {
    case connectivity, serverError, unknown, somethingFishy, custom(String)
    case incorrectUrl, unauthorised
    
    var errorDescription: String {
        switch self {
        case .custom(let message): return message
        case .connectivity: return "INTERNETERROR".localized
        case .serverError, .somethingFishy: return "SERVERERROR".localized
        case .unknown: return "UNKNOWNERROR".localized
        case .incorrectUrl: return "URLDOESNOTEXIST".localized
        default: return "\(self)".localized
        }
    }
}

extension Endpoint {
    func error(from response: Any) -> EndpointError {
        if  let data = response as? NSDictionary,
            let messages = data.allValues as? [[String]]  {
            let message = messages.flatMap { $0 }.joined(separator: ", \n")
            return EndpointError.custom(message)
        }else if let data = response as? NSDictionary, let value = data["detail"] as? String {
            return EndpointError.custom(value)
        }else{
            return EndpointError.unknown
        }
    }
    
    func lookoutForHTTPErrors(in response: HTTPURLResponse?) {
        guard let statusCode = response?.statusCode else {
            alertUserForCommon(error: .somethingFishy)
            return
        }
        switch statusCode {
        case 403: alertUserForCommon(error: .unauthorised)
        case 404: alertUserForCommon(error: .incorrectUrl)
        default: alertUserForCommon(error: .somethingFishy)
        }
    }
    
    private func alertUserForCommon(error: EndpointError) {
        Helper.executeTaskOnMainThread {
            Indicator.shared.hide()
            AppDelegate.shared.window?.currentViewController?
                .showAlertWith(message: .custom(error.errorDescription), buttons: .ok(nil))
        }
    }
}

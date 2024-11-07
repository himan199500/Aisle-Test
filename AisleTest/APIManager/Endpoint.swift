
import Alamofire

typealias WebResponseClosure = ((Result<AnyObject, EndpointError>) -> Void)?

protocol Endpoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
    var encoding: ParameterEncoding { get }
}

//MARK: - Common Properties and Configurations
// these are the basics, we can add more of such details as per the project requirements
extension Endpoint {
    var base: String {
        return "https://app.aisle.co/V1"
    }

    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        switch self {
        default:
            if let token = UserDefaultsManager.loginToken{
                headers["Authorization"] = "\(token)"
            }
        }
        return headers
    }
    
    var request: DataRequest {
        let string = url.description
        if let encodedURL = string.addingPercentEncoding(withAllowedCharacters: .whitespaces){
            print(encodedURL)
        }
        return AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}


import Alamofire

extension Endpoint {    
    private var requestQueue: DispatchQueue {
        return DispatchQueue(
            label: "com.naxariis.ai.request",
            qos: .background,
            attributes: .concurrent,
            autoreleaseFrequency: .inherit,
            target: .global(qos: .default)
        )
    }
    
    /**
     Method for interacting with the server for data
     - parameter api: Endpoints object for preferred data from the server
     - parameter showIndicator: False if you want to interact without the activity indicator
     - parameter completion: A Closure to handle the response from the server
     */
    func execute(
        withHiddenIndicator showIndicator: Bool = true,
        withCompletion completion: WebResponseClosure = nil
    ) {
        guard let networkReachable = NetworkReachabilityManager.default?.isReachable,
            networkReachable else {
                displayAlertWithSettings()
                return
        }
        if showIndicator {
            Indicator.shared.show()
        }
        
        request.responseJSON(queue: requestQueue) { response in
            self.handle(
                response: response,
                withHiddenIndicator: showIndicator,
                withCompletion: completion
            )
        }
    }
    
    private func displayAlertWithSettings() {
        Helper.executeTaskOnMainThread {
            AppDelegate.shared.window?.currentViewController?
                .showAlertWith(message: .internetError, buttons: .ok(nil), .settings)
        }
    }
}

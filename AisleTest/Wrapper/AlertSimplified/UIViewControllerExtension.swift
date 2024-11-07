//
//  UIViewControllerExtension.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//

import UIKit

extension UIViewController {
    /**
     This ia an extension method that displays an alert controller over the current UIViewController.
     - parameter title: An object of AlertTitle, title to display in the alert controller (default is the Application's name).
     - parameter message: An object of Messages, message to display in the alert controller.
     - parameter completionOnPresentationOfAlert: A closure that needs to be executed on presentation of the alert controller (default is nil).
     - parameter buttons: Comma seperated objects of AlertButton to be added to the alert controller
     */
    func showAlertWith(title: AlertTitle = .appName, message: AlertMessages,
                                 completionOnPresentationOfAlert: NullableCompletion = nil,
                                 style: UIAlertController.Style = .alert, buttons: AlertButton...) {
        let alertController = UIAlertController(title: title.value, message: message.value,
                                                preferredStyle: style)
        for button in buttons {
            let alertAction = UIAlertAction(title: button.name, style: button.style) { _ in
                if let actionToPerform = button.action {
                    actionToPerform()
                }
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: completionOnPresentationOfAlert)
    }
    
    /**
     A common method to display the errors from Network requests or any other error,
     if you do not require to handle that error seperately on that particular controller.
     - parameter error: Error thrown either by network calls, or from another sources
     - parameter okHandler: A closure to be executed when user clicks
     */
    func commonAlert(for error: EndpointError, with okHandler: (()->())? = nil) {
        let okAction = AlertButton.ok(okHandler)
        showAlertWith(message: .custom(error.errorDescription), buttons: okAction)
    }
}

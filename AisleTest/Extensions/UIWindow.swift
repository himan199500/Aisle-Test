//
//  UIWindow.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//
import UIKit

extension UIWindow {
    /** Returns the current Top Most ViewController in hierarchy of the window   */
    var topMostWindowController: UIViewController? {
        var topController = rootViewController
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        return topController
    }
    
    /**
     Returns the top most view controller currently being diaplayed
     */
    var currentViewController: UIViewController? {
        var currentViewController = topMostWindowController
        while currentViewController != nil &&
            currentViewController is UINavigationController &&
            (currentViewController as! UINavigationController).topViewController != nil {
                currentViewController = (currentViewController as! UINavigationController).topViewController
        }
        return currentViewController
    }
}

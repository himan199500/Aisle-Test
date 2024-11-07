//
//  Indicator.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//

import UIKit

final class Indicator {
    static let shared = Indicator()
    
    private var indicator = UIActivityIndicatorView()
    private var viewMain = UIView()
    
    private init() {
        viewMain.frame = AppDelegate.shared.window?.frame ?? .zero
        viewMain.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            indicator.style = .large
        }else{
            indicator.style = .whiteLarge
        }
        indicator.startAnimating()
        indicator.center = AppDelegate.shared.window?.center ?? CGPoint.zero
        indicator.color = UIColor.gray
        viewMain.addSubview(indicator)
    }
    
    func show(withBackground value: Bool = false, color: UIColor = UIColor.gray) {
        DispatchQueue.main.async() { [unowned self] in
            AppDelegate.shared.window?.addSubview(self.viewMain)
        }
    }
    
    func hide(){
        DispatchQueue.main.async() { [weak self] in
            self?.viewMain.removeFromSuperview()
        }
    }
}

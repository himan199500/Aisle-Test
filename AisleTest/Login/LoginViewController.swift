//
//  LoginViewController.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//
import Foundation
import UIKit


class LoginViewController:UIViewController{
    
    @IBOutlet private weak var txtFldPhoneNumber:UITextField!
    @IBOutlet weak var txtFldCountryCode:UITextField!
    @IBOutlet weak var lblGetOTP:UILabel!
    @IBOutlet weak var lblEnterNumber:UILabel!
    
    @IBOutlet weak var btnContinue:UIButton!
    
    
    private var countryPickerView = UIPickerView()
    
    let viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = viewModel
        countryPickerView.dataSource = viewModel
        txtFldCountryCode.inputView = countryPickerView
        viewModel.delegate = self
        localizeClass()
    }
    
    private func localizeClass(){
        lblGetOTP.text = "GETOTP".localized
        lblEnterNumber.text = "ENTERNUMBER".localized
        btnContinue.setTitle("CONTINUE".localized, for: .normal)
    }
    
    func perFormValidations(){
        let phoneNumber = txtFldPhoneNumber.text ?? ""
        if phoneNumber.isEmpty{
            showAlertWith(message: .emptyNumber, buttons: .ok(nil))
        }else if phoneNumber.count < 10{
            showAlertWith(message: .invalidNumber, buttons: .ok(nil))
        }else {
            //do API work here.
            viewModel.phoneNumber = phoneNumber
            viewModel.loginUser()
        }
    }
    
    @IBAction func btnContinueAction(sender:UIButton){
        perFormValidations()
    }
}


//MARK: - Login UI UpdateDelegate

extension LoginViewController:PerformUIUpdate{
    func apiSuccessResponse(isSuccess: Bool, error: String?) {
        if isSuccess{
            let vc = OTPViewController.instantiateFrom(storyboard: .main)
            vc.countryCode = txtFldCountryCode.text ?? ""
            vc.phoneNo = txtFldPhoneNumber.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.showAlertWith(message: .custom(error ?? ""), buttons: .ok(nil))
        }
    }
    
    
    func updatedCountryCode(code: String) {
        txtFldCountryCode.text = code
    }
}

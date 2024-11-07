//
//  LoginViewModel.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//
import UIKit

protocol PerformUIUpdate{
    func apiSuccessResponse(isSuccess:Bool,error:String?)
}
 
extension PerformUIUpdate{
    func updatedCountryCode(code:String){}
}


class LoginViewModel:NSObject{
    
    
    let countryCodes = CountryCodes()
    var delegate:PerformUIUpdate?
    var countryCode = "+91"
    var phoneNumber:String = ""
    var otp:String = ""
    
   
    override init() {
        countryCodes.setupCountryCodes()
    }
    
    //Login Api Calling is done here.
    func loginUser(){
        let params = ["number":"\(countryCode)\(phoneNumber)"]
        UserEndpoint.login(params).execute() { [weak self] in
            switch $0 {
            case .success(let data):
                guard let response = data as? NSDictionary else { return }
                guard let status = response["status"] as? Bool else {
                    self?.delegate?.apiSuccessResponse(isSuccess: false, error: "Failed to parse response")
                    return}
                self?.delegate?.apiSuccessResponse(isSuccess: status, error: status == true ? nil : "Invalid Credentials")
            case .failure(let error):
                self?.delegate?.apiSuccessResponse(isSuccess: false, error: error.errorDescription)
            }
        }
    }
    
    func verifyOtp(){
        let params = ["number":"\(countryCode)\(phoneNumber)","otp":otp]
        UserEndpoint.verifyOtp(params).execute() { [weak self] in
            switch $0 {
            case .success(let data):
                guard let response = data as? NSDictionary else { return }
                guard let token = response["token"] as? String else {
                    self?.delegate?.apiSuccessResponse(isSuccess: false, error: "Failed to parse response")
                    return}
                UserDefaultsManager.loginToken = token
                self?.delegate?.apiSuccessResponse(isSuccess: true, error: nil)
            case .failure(let error):
                self?.delegate?.apiSuccessResponse(isSuccess: false, error: error.errorDescription)
            }
        }
    }
}


//MARK: - Picker View Delegate and data Source
extension LoginViewModel:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryCodes.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countryCodes.countries[row].0) +\(countryCodes.countries[row].1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.updatedCountryCode(code: "+\(countryCodes.countries[row].1)")
    }
}


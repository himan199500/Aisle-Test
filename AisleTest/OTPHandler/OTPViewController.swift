//
//  OTPViewController.swift
//  AisleTest
//
//  Created by Himanshu Soni on 07/11/24.
//
import UIKit

class OTPViewController:UIViewController{
    
    @IBOutlet weak var lblPhoneNo:UILabel!
    @IBOutlet weak var lblEnterOtp:UILabel!
    @IBOutlet weak var lblTimer:UILabel!
    @IBOutlet weak var txtFldOtp:UITextField!
    @IBOutlet weak var btnContinue:UIButton!
    @IBOutlet weak var btnResend:UIButton!
    
    var phoneNo:String = ""
    var countryCode:String = ""
    var counter = 59
    let viewModel = LoginViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPhoneNo.text = "\(countryCode)\(phoneNo)"
        viewModel.phoneNumber = phoneNo
        localizeClass()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startTimer()
    }
    
    
    private func localizeClass(){
        lblEnterOtp.text = "ENTEROTP".localized
        btnContinue.setTitle("CONTINUE".localized, for: .normal)
    }
    
    private func startTimer() {
        counter = 59
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            if let self = self {
                self.counter = self.counter - 1
                let counterValue = self.counter
                var strCounterValue = String(self.counter)
                if counterValue < 10 {
                    strCounterValue = String(0) + String(counterValue)
                }
                DispatchQueue.main.async {
                    self.lblTimer.text = "00:" + strCounterValue
                }
                if self.counter == 0 {
                    timer.invalidate()
                    self.btnResend.isEnabled = true
                    self.btnResend.isHidden = false
                    self.lblTimer.isHidden = true
                }
            }
        }
    }
    
    func perFormValidations(){
        let otp = txtFldOtp.text ?? ""
        if otp.isEmpty{
            showAlertWith(message: .emptyOtp, buttons: .ok(nil))
        }else if otp.count < 4{
            showAlertWith(message: .invalidOTP, buttons: .ok(nil))
        }else {
            //do API work here.
            viewModel.otp = otp
            viewModel.verifyOtp()
        }
    }
    
    @IBAction func btnContinueAction(sender:UIButton){
        perFormValidations()
    }
    
    
    @IBAction func btnEditAction(sender:UIButton){
        self.showAlertWith(message: .custom("This action will take you back to login screen, Are you sure you want to proceed?"), buttons: .ok({
            self.navigationController?.popViewController(animated: true)
        }),.cancel)
    }
}

//MARK: - View Model Delegations
extension OTPViewController:PerformUIUpdate{
      func apiSuccessResponse(isSuccess: Bool, error: String?) {
        if isSuccess{
            let controller = NotesViewController.instantiateFrom(storyboard: .aisle)
            let navController = UINavigationController(rootViewController: controller)
            navController.isNavigationBarHidden = true
            navController.navigationBar.backgroundColor = .white
            UIWindow.key?.rootViewController = navController
            UIWindow.key?.makeKeyAndVisible()
        }else{
            self.showAlertWith(message: .custom(error), buttons: .ok(nil))
        }
    }
}

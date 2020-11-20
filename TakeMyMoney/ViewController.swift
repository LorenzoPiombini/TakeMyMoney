//
//  ViewController.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/17/20.
//

import UIKit

@IBDesignable
class ViewController: UIViewController, UITextFieldDelegate {

    override class func prepareForInterfaceBuilder() {
        self
    }
    
    @IBOutlet weak var scrollViewtohide: UIScrollView!
    @IBOutlet weak var textFieldWithInTheScrollView: UITextField!
    @IBOutlet weak var passwordInputTextFieldPayPal: UITextField!
    @IBOutlet weak var creditCardCVV: UITextField!
    @IBOutlet weak var creditCardTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputTextFieldPayPal.isSecureTextEntry = true
        //to hide the scrollview :
        scrollViewtohide.alpha = 0
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func showingPayPal(_ sender: UIButton){
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { self.scrollViewtohide.alpha = 0.0}, completion: nil)
       
        
    }
    
    @IBAction func showingTheScrollView(_ sender: UIButton){
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {self.scrollViewtohide.isHidden = false; self.scrollViewtohide.alpha = 1.0}, completion: nil)
        
    }

    
    @IBAction func checkingRightValues(_ sender: Any) {
        checkingCVVforNumbers()
    }
    
    func checkIfThereIsalredyInputsInCVV()-> Bool{
        if creditCardCVV.text!.count >= 2 {
            return true
        }else {
            return false
        }
    }
    
    func checkingCVVforNumbers(){
        //this is too handle inputs when you are using the simulator cause you can use tha actual
        //keyboard
        if creditCardCVV.text != "" {
        if Int(creditCardCVV.text!) == nil {
            let alertMessage = UIAlertController.init(title: "Your Entry is invalid", message: "only numbers please", preferredStyle: .alert)
            let okay = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(okay)
            self.present(alertMessage, animated: true, completion: nil)
            if checkIfThereIsalredyInputsInCVV() {
                creditCardCVV.text?.removeLast()
            }else{
                creditCardCVV.text? = ""
            }
        }
    }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        creditCardCVV.resignFirstResponder()
        return true
    }
    
    
    func masterCard()->Bool {
        if creditCardTextField.text!.hasPrefix("51") || creditCardTextField.text!.hasPrefix("52") || creditCardTextField.text!.hasPrefix("53") || creditCardTextField.text!.hasPrefix("54") ||
            creditCardTextField.text!.hasPrefix("55") {
            return true
                   
        } else {
            return false
        }
    }
    
    
    @IBAction func findingTheCreditCardBrend(_ sender: Any) {
       whichcreditcard()
    }
    
    func whichcreditcard() {
        // you have to resize better the image 
        if masterCard() {
            creditCardTextField.leftViewMode = .always
            let imageView = UIImageView()
            let Image = UIImage(named: "mc_symbol_opt_45_3x.png")
            imageView.image = Image
            let height = creditCardTextField.frame.size.height
            creditCardTextField.leftView = imageView
            creditCardTextField.leftView?.frame = CGRect(x: 0, y: 0, width: creditCardTextField.frame.size.width / 4, height: height)
        }
        
    }
}


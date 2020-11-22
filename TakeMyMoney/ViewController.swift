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
    @IBOutlet weak var creditCardTextField:UITextField!
    @IBOutlet weak var validUntilTextField: UITextField!
    
    var userCreditCardInput:String = ""
    var storingValues = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputTextFieldPayPal.isSecureTextEntry = true
        creditCardCVV.isSecureTextEntry = true
        
        //to hide the scrollviews with the credit CardData :
        scrollViewtohide.alpha = 0
        
        
        
        
    
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func showingPayPal(_ sender: UIButton){
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { self.scrollViewtohide.alpha = 0.0}, completion: nil)
       
        
    }
    
    @IBAction func showingTheScrollView(_ sender: UIButton){
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {self.scrollViewtohide.isHidden = false; self.scrollViewtohide.alpha = 1.0}, completion: nil)
        
    }

    

    
    
   // Checking the values for CVV fields
    
    @IBAction func checkingRightValues(_ sender: Any) {
        checkingCVVforNumbers()
    }
    
    // function to be called in the checkingRightValues IBAction
    func checkIfThereIsalredyInputsInCVV()-> Bool{
        if creditCardCVV.text!.count >= 2 {
            return true
        }else {
            return false
        }
    }
    
    func checkingCVVforNumbers(){
        
        /* this handles inputs when you are using the simulator cause you can use tha actual
        keyboard,  */
        
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
    
    
    
    // group of functions checking the creditCard brend
    
    func amex(UserInput: String) -> Bool {
        if UserInput.hasPrefix("34") || UserInput.hasPrefix("37"){
            return true
        } else {
            return false
        }
    }
    func discover (UserInput: String) -> Bool {
        if UserInput.hasPrefix("6011") || UserInput.hasPrefix("68"){
            return true
        } else
        {
            return false
        }
        
    }
    func visa(UserInput: String) -> Bool {
        if UserInput.hasPrefix("4") {
            return true
        } else {
            return false
        }
    }
    
    func masterCard(UserInput: String)->Bool {
        if UserInput.hasPrefix("51") || UserInput.hasPrefix("52") || UserInput.hasPrefix("53") || UserInput.hasPrefix("54") ||
            UserInput.hasPrefix("55") {
            return true
                   
        } else {
            return false
        }
    }
    
    
    @IBAction func findingTheCreditCardBrend(_ sender: Any) {
        
       var newValue = ""
        if creditCardTextField.text == "" {
            creditCardTextField.leftViewMode = .never
        } else {
            newValue = secureInputwithAnotherChar(TextField: creditCardTextField)
                    whichcreditcard(forUserInput: newValue)
           
                        }
                    }
        
                
        
    
    func secureInputwithAnotherChar(TextField: UITextField)-> String{
        
        if TextField.text == "" {
            TextField.text = "*"
        }else {
            storingValues += TextField.text!
            for _ in storingValues {
                if let index = storingValues.firstIndex(of: "*") {
            storingValues.remove(at: index)
            }
               
            }
        }
        TextField.text = ""
        for _ in storingValues{
            TextField.text?.append("*")
        }
        
        return storingValues
    }
    
    

    //putting the Credit Card brand image in place
    func whichcreditcard(forUserInput:String) {
        if masterCard(UserInput: forUserInput) {
            creditCardTextField.leftViewMode = .always
            let imageView = UIImageView()
            let Image = UIImage(named: "mc_symbol_opt_45_3x.png")
            imageView.image = Image
            creditCardTextField.leftView = imageView
            
        }else if visa(UserInput: forUserInput){
            creditCardTextField.leftViewMode = .always
            let imageView = UIImageView()
            let image = UIImage(named: "visa.png")
            imageView.image = image
            creditCardTextField.leftView = imageView
        }else if discover(UserInput: forUserInput){
            creditCardTextField.leftViewMode = .always
            let imageView = UIImageView()
            let image = UIImage(named: "discover.png")
            imageView.image = image
            creditCardTextField.leftView = imageView
        }else if amex(UserInput: forUserInput) {
            creditCardTextField.leftViewMode = .always
            let imageView = UIImageView()
            let image = UIImage(named: "amex.png")
            imageView.image = image
            creditCardTextField.leftView = imageView
        }
        
    }
    
    // handle the credit card textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0{
            return true
        }else if textField.text!.count > 0{
            return true
        }
    return true
     
}

}

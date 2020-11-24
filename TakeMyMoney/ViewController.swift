//
//  ViewController.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/17/20.
//

import UIKit

@IBDesignable
class ViewController: UIViewController, UITextFieldDelegate {

    override  func prepareForInterfaceBuilder() {
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
    var countingToAllowDeleteaction = 0
    var didBackSpaceSelect = false
    
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
            newValue = secureInputwithAnotherChar(TextField: creditCardTextField)
                    whichcreditcard(forUserInput: newValue)
        } else {
            newValue = secureInputwithAnotherChar(TextField: creditCardTextField)
                    whichcreditcard(forUserInput: newValue)
                    
                        }
        if !didBackSpaceSelect {
            formattingTheCreditCardSecuredNumberWithSpace(CreditCardTextField: creditCardTextField)
        }
        }
     
                    
        
              
    func formattingTheCreditCardSecuredNumberWithSpace(CreditCardTextField: UITextField){
        if creditCardTypeWith16numbers(forThisIDNumber: storingValues){
            switch storingValues.count {
            case 5:
                let index = CreditCardTextField.text!.lastIndex(of: "*")
                CreditCardTextField.text!.insert(" ", at: index!)
            case 9:
                let index = CreditCardTextField.text!.lastIndex(of: "*")
                CreditCardTextField.text!.insert(" ", at: index!)
            case 13:
                let lastInput = CreditCardTextField.text!.removeLast()
                CreditCardTextField.text!.append(lastInput)
                let index = CreditCardTextField.text!.lastIndex(of: lastInput)
                CreditCardTextField.text!.insert(" ", at: index!)
            default:
                break
            }
        } else {
            switch storingValues.count {
            case 5:
                let index = CreditCardTextField.text!.lastIndex(of: "*")
                CreditCardTextField.text!.insert(" ", at: index!)
            case 11:
                let index = CreditCardTextField.text!.lastIndex(of: "*")
                CreditCardTextField.text!.insert(" ", at: index!)
            
            default:
                break
            }
        }
        
        
    }
  
    
    func secureInputwithAnotherChar(TextField: UITextField)-> String{
    if storingValues.count >= 12 && creditCardTypeWith16numbers(forThisIDNumber: storingValues) {
         let lastInput = TextField.text!.removeLast()
        switch lastInput {
        case "*":
            storingValues.removeLast()
            didBackSpaceSelect = true
        case " ":
            storingValues.removeLast()
            didBackSpaceSelect = true
        default:
            storingValues += "\(lastInput)"
            TextField.text!.append(lastInput)
        }
           
            
        } else if  TextField.text!.count > countingToAllowDeleteaction && storingValues.count < 5 {
            storingValues += TextField.text!
            for _ in storingValues {
                if let index = storingValues.firstIndex(of: "*") {
            storingValues.remove(at: index)
                } else if let index2 = storingValues.firstIndex(of: " "){
                    storingValues.remove(at: index2)
                }
            }
            TextField.text = String(repeating: "*", count: storingValues.count)
            
            countingToAllowDeleteaction = TextField.text!.count
          
        }else if  TextField.text!.count > countingToAllowDeleteaction &&  storingValues.count >= 5 && storingValues.count < 9 {
            storingValues += TextField.text!
            for _ in storingValues {
                if let index = storingValues.firstIndex(of: "*") {
            storingValues.remove(at: index)
                } else if let index2 = storingValues.firstIndex(of: " "){
                    storingValues.remove(at: index2)
                }
            }
            TextField.text = "**** " + String(repeating: "*", count: storingValues.count - 4)
            countingToAllowDeleteaction = storingValues.count
    }else if  TextField.text!.count > countingToAllowDeleteaction && storingValues.count >= 9 {
        storingValues += TextField.text!
        for _ in storingValues {
            if let index = storingValues.firstIndex(of: "*") {
        storingValues.remove(at: index)
            } else if let index2 = storingValues.firstIndex(of: " "){
                storingValues.remove(at: index2)
            }
        }
        TextField.text = "**** **** " + String(repeating: "*", count: storingValues.count - 8)
        countingToAllowDeleteaction = storingValues.count
    }else if TextField.text!.count < countingToAllowDeleteaction && TextField.text!.count > 1{
            storingValues.removeLast()
//            for _ in storingValues {
//                if let index = storingValues.firstIndex(of: "*") {
//            storingValues.remove(at: index)
//            }
//            }
            TextField.text = String(repeating: "*", count: storingValues.count)
            countingToAllowDeleteaction = TextField.text!.count
        } else if TextField.text!.count < countingToAllowDeleteaction && TextField.text!.count == 1 {
            storingValues.removeLast()
            for _ in storingValues {
                if let index = storingValues.firstIndex(of: "*") {
            storingValues.remove(at: index)
            }
            }
            TextField.text = String(repeating: "*", count: storingValues.count)
            countingToAllowDeleteaction = TextField.text!.count
        } else if TextField.text!.count == 0  {
            storingValues = ""
            countingToAllowDeleteaction = 0
        }
        
        
        
        
        return storingValues
        
    }
    
    
    func creditCardTypeWith16numbers(forThisIDNumber: String)->Bool {
        if masterCard(UserInput: forThisIDNumber ) || visa(UserInput: forThisIDNumber) || discover(UserInput: forThisIDNumber){
            return true
        }else {
            return false
        }
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
    return false
     
}

}

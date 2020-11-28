//
//  ViewController.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/17/20.
//

import UIKit

protocol userInteraction {
   func didUsereSelectTheTextField(textField: UITextField)
}

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
    
    var datePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputTextFieldPayPal.isSecureTextEntry = true
        creditCardCVV.isSecureTextEntry = true
        
        //to hide the scrollviews with the credit Card fields :
        scrollViewtohide.alpha = 0
        
        validUntilTextField.delegate = self
        makingDatePicker()
        
        
    
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
    
   
    
    
  
    @IBAction func changingvalue(_ sender: UITextField) {
        sender.becomeFirstResponder()
        print("yes")
    }
    
    
    @IBAction func showingDatePicker(_ sender: Any) {
        
        
     
//
//        let alertDate = UIAlertController (title: "Credit Card Valid Until", message: "pick the date on your card", preferredStyle: .alert)
//
//        alertDate.addTextField(configurationHandler: {(textField) in
//            self.makingDatePicker()
//            textField.inputView = self.datePicker
//
//        })
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//            toolBar.isTranslucent = true
//            toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//            toolBar.sizeToFit()
//        self.present(alertDate, animated: true, completion: nil)
//        alertDate
    }
    
    func makingDatePicker() {
         let formatter = DateFormatter()
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 220, width: self.view.frame.size.width, height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        formatter.dateFormat = "MM-yyyy"
        validUntilTextField.inputView = self.datePicker
        validUntilTextField.inputAccessoryView = self.toolBar
        toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
            toolBar.sizeToFit()
        
        let Done = UIBarButtonItem(title: "Done", style: .plain, target: self, action:#selector(self.doneHasBeenTapped))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(self.cancelHasBeenTapped))
        let delete = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(self.deletingTheDate))
        toolBar.setItems([Done, cancel, delete], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.toolBar.isHidden = false
        
        
        
    
        
    }
    
     @objc func doneHasBeenTapped(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        validUntilTextField.text = formatter.string(from: datePicker.date)
        validUntilTextField.resignFirstResponder()
        self.makingDatePicker() // called again to allow the User to change the date
    }
   @objc func cancelHasBeenTapped (){
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    validUntilTextField.resignFirstResponder()
    self.makingDatePicker()
    }
    
    @objc func deletingTheDate(){
        validUntilTextField.text?.removeAll()
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
                 didBackSpaceSelect = false
             }else {
                 didBackSpaceSelect = false
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
//            case 10:
//
//                CreditCardTextField.text!.append(" ")
//
            default:
                break
            }
        }
        
        
    }
  
    func DidDeleteChars(inThisTxtField: UITextField) -> Bool {
        if countingToAllowDeleteaction > inThisTxtField.text!.count {
            return true
        }else {
            return false
        }
    }
    
    // secureInputwithAnotherChar V 1.0 11/24/20 it works with Mastercard Discover and Visa, Amex format has not been implemented yet
    /**
     The secureInputwithAnotherChar is the core function to secure the input besides
     the last four digits of the credit card. it works with other functions in orther to secure and guarnted the outcome
     
      - parameter TextField: is the place where the input takes place. The user will put the credit Card number in, and the latter will be secured with "*" apart from the last four digits.
       
      - returns  : a String variable storing the Credit Card Number from the user, this variable will be use in onther functions like whichcreditcard to obtain the credit Card brend.
     
       this method works with DidDeleteChars, creditCardTypeWith16numbers:
       DidDeleteChars(inThisTxtField: UITextField) - > Bool {}, will return true when backSpace on the nkeyboard has been tapped and false when it wil not be the case. creditCardTypeWith16numbers -> Bool will return true when the credit card bred is one between MasterCard, Visa, or Discover
                                            
                               
     */
    
    func secureInputwithAnotherChar(TextField: UITextField)-> String{
    
        
        if DidDeleteChars(inThisTxtField: creditCardTextField) && creditCardTypeWith16numbers(forThisIDNumber: storingValues) {
            if storingValues.count > 1 {
            storingValues.removeLast()
                countingToAllowDeleteaction = TextField.text!.count
                didBackSpaceSelect = true
                switch TextField.text!.count {
                case 14:
                    TextField.text?.removeLast()
                    countingToAllowDeleteaction = TextField.text!.count
                case 9:
                    TextField.text?.removeLast()
                    countingToAllowDeleteaction = TextField.text!.count
                case 4:
                    TextField.text?.removeLast()
                    countingToAllowDeleteaction = TextField.text!.count
                default:
                    break
                }
            }else {
                storingValues = ""
                countingToAllowDeleteaction = 0
            }
        } else if DidDeleteChars(inThisTxtField: creditCardTextField) && creditCardTypeWith16numbers(forThisIDNumber: storingValues) == false{
            if storingValues.count > 1 {
                
            storingValues.removeLast()
                countingToAllowDeleteaction = TextField.text!.count
                didBackSpaceSelect = true
                switch TextField.text!.count {
                case 11:
                    TextField.text?.removeLast()
                    countingToAllowDeleteaction = TextField.text!.count
                case 4:
                    TextField.text?.removeLast()
                    countingToAllowDeleteaction = TextField.text!.count
                default:
                    break
                    
                }
            } else {
                storingValues = ""
                countingToAllowDeleteaction = 0
                
            }
    }else if storingValues.count >= 12 && creditCardTypeWith16numbers(forThisIDNumber: storingValues) {
         let lastInput = TextField.text!.removeLast()
            storingValues += "\(lastInput)"
            TextField.text!.append(lastInput)
        countingToAllowDeleteaction = TextField.text!.count
    } else if storingValues.count >= 11 && (creditCardTypeWith16numbers(forThisIDNumber: storingValues) == false){
        let lastInput = TextField.text!.removeLast()
           storingValues += "\(lastInput)"
           TextField.text!.append(lastInput)
       countingToAllowDeleteaction = TextField.text!.count
        
        
    }else if  TextField.text!.count > countingToAllowDeleteaction && storingValues.count < 5 {
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
          
        }else if  TextField.text!.count > countingToAllowDeleteaction &&  storingValues.count >= 5 && storingValues.count < 9 && (creditCardTypeWith16numbers(forThisIDNumber: storingValues)){
            storingValues += TextField.text!
            for _ in storingValues {
                if let index = storingValues.firstIndex(of: "*") {
            storingValues.remove(at: index)
                } else if let index2 = storingValues.firstIndex(of: " "){
                    storingValues.remove(at: index2)
                }
            }
            TextField.text = "**** " + String(repeating: "*", count: storingValues.count - 4)
            countingToAllowDeleteaction = TextField.text!.count
    }else if  TextField.text!.count > countingToAllowDeleteaction && storingValues.count >= 9 && (creditCardTypeWith16numbers(forThisIDNumber: storingValues)) {
        storingValues += TextField.text!
        for _ in storingValues {
            if let index = storingValues.firstIndex(of: "*") {
        storingValues.remove(at: index)
            } else if let index2 = storingValues.firstIndex(of: " "){
                storingValues.remove(at: index2)
            }
        }
        TextField.text = "**** **** " + String(repeating: "*", count: storingValues.count - 8)
        countingToAllowDeleteaction = TextField.text!.count
    }else if TextField.text!.count > countingToAllowDeleteaction &&  storingValues.count >= 5  && storingValues.count < 10 && (creditCardTypeWith16numbers(forThisIDNumber: storingValues) == false){
        storingValues += TextField.text!
        for _ in storingValues {
            if let index = storingValues.firstIndex(of: "*") {
        storingValues.remove(at: index)
            } else if let index2 = storingValues.firstIndex(of: " "){
                storingValues.remove(at: index2)
            }
        }
        TextField.text = "**** " + String(repeating: "*", count: storingValues.count - 4)
        countingToAllowDeleteaction = TextField.text!.count
        
    }  else if TextField.text!.count > countingToAllowDeleteaction &&  storingValues.count == 10 &&  (creditCardTypeWith16numbers(forThisIDNumber: storingValues) == false){
        storingValues += TextField.text!
        for _ in storingValues {
            if let index = storingValues.firstIndex(of: "*") {
        storingValues.remove(at: index)
            } else if let index2 = storingValues.firstIndex(of: " "){
                storingValues.remove(at: index2)
            }
        }
        TextField.text = "**** ****** " + String(repeating: "*", count: storingValues.count - 10)
        countingToAllowDeleteaction = TextField.text!.count
        
    }
        
    
        
        
        
        print(storingValues)
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
    
//    countingToAllowDeleteaction > textField.text!.count{
//                        textField.text!.append("\(value!)")
//                        return true
//                    }else {
//                        return false
//                    }
//        } else if textField.text!.count == 1 {
//            let value = textField.text!
//                    if let number  = Int("\(String(value))") {
//                        if creditCardTypeWith16numbers(forThisIDNumber: storingValues) && textField.text!.count == 19{
//                            return false
//                            } else if amex(UserInput: storingValues) && textField.text!.count == 17{
//                            return false
//                               } else {
//                               return true
//                              }
//                    }else if countingToAllowDeleteaction > textField.text!.count{
//                        return true
//                    }else {
//                        textField.text = ""
//                        return false
//                    }
//        }
//
    
      
         
            

    
       
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//
//
//    }
                  
}

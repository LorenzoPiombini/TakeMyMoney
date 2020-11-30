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
    
    
    var datePicker = UIDatePicker() // used this variable to put as a InputView for a specific textField
    
    let toolBar = UIToolbar() // use this variiables to add the Done cancel and delete buttons to close the pin pad keyboards or the Date picker
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputTextFieldPayPal.isSecureTextEntry = true
        creditCardCVV.isSecureTextEntry = true
        
        //to hide the scrollviews with the credit Card fields :
        scrollViewtohide.alpha = 0
        
        validUntilTextField.delegate = self
        creditCardTextField.inputAccessoryView = addingToolBar(inThisTextField: creditCardTextField)
        creditCardCVV.inputAccessoryView = addingToolBar(inThisTextField: creditCardCVV)
        makingDatePickerInputView(inThisTextField: validUntilTextField)
        textFieldWithInTheScrollView.inputAccessoryView = addingToolBar(inThisTextField: textFieldWithInTheScrollView)
        
        //when you hit the textFieldWithInTheScrollView the keyboard cover the card holder name textfield. the follwing allowdme to move the TextField up within the screen so you can see where you are writing in
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        // Do any additional setup after loading the view.
        
        
    }

    // object-C function to help move up the ViewController when the card name holder textfield is selected
    @objc func keyboardWillShow(notification: NSNotification){
        if textFieldWithInTheScrollView.isFirstResponder {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
        }
    }
    
    // object-C function to help move up the ViewController when the card name holder textfield is selected
    @objc func keyboardWillHide(notification: NSNotification){
       
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        
    }
    }
    
    //paypal btn action
    @IBAction func showingPayPal(_ sender: UIButton){
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { self.scrollViewtohide.alpha = 0.0}, completion: nil)
       
        
    }
    
    //Credit card button action
    @IBAction func showingTheScrollView(_ sender: UIButton){
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {self.scrollViewtohide.isHidden = false; self.scrollViewtohide.alpha = 1.0}, completion: nil)
        
    }

    
   // returning a message if it is not a number
    func messageToTheUserIfNotAnumber(textField: UITextField)-> Bool{
        var input:Character
        if textField.text!.count > 1 {
            input = textField.text!.removeLast()
        if Int(String(input)) == nil && input != "*" {
            let alertMessage = UIAlertController.init(title: "Your Entry is invalid", message: "only numbers please", preferredStyle: .alert)
            let okay = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(okay)
            self.present(alertMessage, animated: true, completion: nil)
            return true
        }else {
            textField.text?.append(input)
            return false
        
    }
        } else {
            if Int(textField.text!) == nil {
                let alertMessage = UIAlertController.init(title: "Your Entry is invalid", message: "only numbers please", preferredStyle: .alert)
                let okay = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alertMessage.addAction(okay)
                self.present(alertMessage, animated: true, completion: nil)
                textField.text = ""
                return true
            }else {
                return false
            
        }
        }
    }
    
    
   // Checking the values for CVV fields
    
    @IBAction func checkingRightValues(_ sender: Any) {
        checkingforNumbers(textField: creditCardCVV)
    }
    
    // function to be called in the checkingRightValues IBAction
    func countingHowManyCharInThe(textField: UITextField)-> Bool{
        if textField.text!.count >= 2 {
            return true
        }else {
            return false
        }
    }
    
    func checkingforNumbers(textField: UITextField)-> Bool{
        
        /* this handles inputs when you are using the simulator cause you can use tha actual
        keyboard, I developed this project using my phone   */
        
        if textField.text != "" {
            if messageToTheUserIfNotAnumber(textField: textField){
              
                    return false
            }else {
                return true
            }
        }
        return true
    }
    
   
    
    
  
    @IBAction func changingvalue(_ sender: UITextField) {
        sender.becomeFirstResponder()
        print("yes")
    }
    
    
 
    
    func addingToolBar(inThisTextField: UITextField) -> UIToolbar{
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .white
        toolBar.sizeToFit()
        //adding buttons
       
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneHasBeenTapped))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelHasBeenTapped))
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(self.deletingTheDate))
        toolBar.setItems([done, cancel, clear], animated: true)
            toolBar.isUserInteractionEnabled = true
            toolBar.isHidden = false
       
        
       return toolBar
    }
    
    func makingDatePickerInputView(inThisTextField: UITextField) {
         let formatter = DateFormatter()
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 220, width: self.view.frame.size.width, height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        formatter.dateFormat = "MM-yyyy"
        inThisTextField.inputView = self.datePicker
        inThisTextField.inputAccessoryView = self.addingToolBar(inThisTextField: inThisTextField)
    
        
    }
    
    @objc func doneHasBeenTapped(){
        
        let textFieldsCollection = [creditCardTextField, validUntilTextField, creditCardCVV, textFieldWithInTheScrollView]
        var index = 0
        for _ in textFieldsCollection{
            if textFieldsCollection[index]?.isFirstResponder == true {
            if textFieldsCollection[index]?.inputView == datePicker {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/yyyy"
                datePicker.isHidden = true
                self.toolBar.isHidden = true
                textFieldsCollection[index]?.text = formatter.string(from: datePicker.date)
                textFieldsCollection[index]?.resignFirstResponder()
                self.makingDatePickerInputView(inThisTextField: textFieldsCollection[index]!)
            } else {
                self.toolBar.isHidden = true
                textFieldsCollection[index]?.resignFirstResponder()
                textFieldsCollection[index]?.inputAccessoryView = addingToolBar(inThisTextField: textFieldsCollection[index]!)
            }
               
        }
            index += 1
        }
    }
        
     
    @objc func cancelHasBeenTapped(){
        let textFieldsCollection = [creditCardTextField, validUntilTextField, creditCardCVV, textFieldWithInTheScrollView]
        var index = 0
        for _ in textFieldsCollection{
            if textFieldsCollection[index]?.isFirstResponder == true {
            if textFieldsCollection[index]?.inputView == datePicker {
                 datePicker.isHidden = true
                   self.toolBar.isHidden = true
                textFieldsCollection[index]?.resignFirstResponder()
             self.makingDatePickerInputView(inThisTextField: textFieldsCollection[index]!)
        }else {
        self.toolBar.isHidden = true
        textFieldsCollection[index]?.resignFirstResponder()
            textFieldsCollection[index]?.inputAccessoryView = addingToolBar(inThisTextField: textFieldsCollection[index]!)
    }
        
    }
            index += 1
        }
    }
    
    @objc func deletingTheDate(){
        let textFieldsCollection = [creditCardTextField, validUntilTextField, creditCardCVV, textFieldWithInTheScrollView]
        var index = 0
        for _ in textFieldsCollection{
            if textFieldsCollection[index]?.isFirstResponder == true {
            if textFieldsCollection[index]?.inputView == datePicker {
        textFieldsCollection[index]?.text?.removeAll()
            } else {
                textFieldsCollection[index]?.text = ""
            }
            }
        index += 1
        }
        
        if textFieldsCollection[0]!.text!.count < countingToAllowDeleteaction {
            countingToAllowDeleteaction = 0
            storingValues = ""
            didBackSpaceSelect = false
            
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
        
        if textFieldShouldBeginEditing(creditCardTextField){
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
       

        } else {
            print("false")
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
    
      
         
        //this function gives a Bool value: if the credit card number is complete, the user won`t be allowed to enter any inputs

    func stopInputIfcreditCardNumberHasTheMaxlenght(textField: UITextField) -> Bool {
        if textField.text!.count == 20 && creditCardTypeWith16numbers(forThisIDNumber: storingValues) {
            return true
        }else if textField.text!.count == 18 && (creditCardTypeWith16numbers(forThisIDNumber: storingValues)) == false {
            return true
        }else {
            return false
        }
    }
       
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if DidDeleteChars(inThisTxtField: textField){
            return true
        } else if checkingforNumbers(textField: textField) && stopInputIfcreditCardNumberHasTheMaxlenght(textField: textField) {
            textField.text?.removeLast()
            return false
        }else if stopInputIfcreditCardNumberHasTheMaxlenght(textField: textField) && checkingforNumbers(textField: textField){
            return false
        }else if stopInputIfcreditCardNumberHasTheMaxlenght(textField: textField) == false && checkingforNumbers(textField: textField) {
            return true
        } else {
            return false
        }

    }
                  
}

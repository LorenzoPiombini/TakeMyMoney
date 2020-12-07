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
    @IBOutlet weak var creditCardLbl: UILabel!
    @IBOutlet weak var cvvLbl: UILabel!
    @IBOutlet weak var validUntilLbl: UILabel!
    @IBOutlet weak var cardHolderLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var scrollViewtohide: UIScrollView!
    @IBOutlet weak var cardHolderTextField: UITextField!
    @IBOutlet weak var passwordInputTextFieldPayPal: UITextField!
    @IBOutlet weak var creditCardCVV: UITextField!
    @IBOutlet weak var creditCardTextField:UITextField!
    @IBOutlet weak var validUntilTextField: UITextField!
    @IBOutlet weak var proceedToConfirmBtn: UIButton!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField:UITextField!
    @IBOutlet weak var  paypalBtn: UIButton!
    @IBOutlet weak var creditCardBtn: UIButton!
    
    var datePicker = UIDatePicker() // used this variable to put as a InputView for a specific textField
    
    let toolBar = UIToolbar() // use this variiables to add the Done cancel and delete buttons to close the pin pad keyboards or the Date picker
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputTextFieldPayPal.isSecureTextEntry = true
        creditCardCVV.isSecureTextEntry = true
       
        creditCardBtn.alpha = 0.4
        //to hide the scrollviews with the credit Card fields :
        scrollViewtohide.alpha = 0
        
        passwordTxtField.inputAccessoryView = addingToolBar(inThisTextField: passwordTxtField)
        usernameTxtField.inputAccessoryView = addingToolBar(inThisTextField: usernameTxtField)
        creditCardTextField.inputAccessoryView = addingToolBar(inThisTextField: creditCardTextField)
        creditCardCVV.inputAccessoryView = addingToolBar(inThisTextField: creditCardCVV)
        makingDatePickerInputView(inThisTextField: validUntilTextField)
        cardHolderTextField.inputAccessoryView = addingToolBar(inThisTextField: cardHolderTextField)
        
        //when you hit the textFieldWithInTheScrollView the keyboard cover the card holder name textfield. the follwing allowdme to move the TextField up within the screen so you can see where you are writing in
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        // Do any additional setup after loading the view.
        
        
    }

    // object-C function to help move up the ViewController when the card name holder textfield is selected
    @objc func keyboardWillShow(notification: NSNotification){
        if cardHolderTextField.isFirstResponder || passwordTxtField.isFirstResponder {
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
        creditCardBtn.alpha = 0.4
        paypalBtn.alpha = 1
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { self.scrollViewtohide.alpha = 0.0}, completion: nil)
       
        
    }
    
    //Credit card button action
    @IBAction func showingTheScrollView(_ sender: UIButton){
        paypalBtn.alpha = 0.4
        creditCardBtn.alpha = 1
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {self.scrollViewtohide.isHidden = false; self.scrollViewtohide.alpha = 1.0}, completion: nil)
        
    }

    @IBAction func dateTextFieldIsEditing(_ sender:Any){
        validUntilLbl.text = "Valid until"
        validUntilLbl.textColor = .darkGray
        resettingTextFieldToOriginaFormat(textField: validUntilTextField)
    }
    
    @IBAction func UsernameIsEditing(_ sender: Any){
        usernameLbl.text = "Username"
        usernameLbl.textColor = .darkGray
        resettingTextFieldToOriginaFormat(textField: usernameTxtField)
        
    }
    
    @IBAction func PasswordTxtFieldIsEditing(_ seder: Any){
        passwordLbl.text = "Password"
        passwordLbl.textColor = .darkGray
        resettingTextFieldToOriginaFormat(textField: passwordTxtField)
    }
    
    
    
    
   // returning a message if it is not a number and check if it is a number at the same time
    func messageToTheUserIfNotAnumber(textField: UITextField)-> Bool{
        var input:Character
        if textField.text!.count > 1 {
            input = textField.text!.removeLast()
        if Int(String(input)) == nil && input != "*" && input != " " {
            if textField != cardHolderTextField{
            let alertMessage = UIAlertController.init(title: "Your Entry is invalid", message: "", preferredStyle: .alert)
            let okay = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(okay)
            self.present(alertMessage, animated: true, completion: nil)
            return true
            }else{
            
                
                textField.text?.append(input)
                return true
            }
        }else {
            if input == " " && textField == cardHolderTextField {
                textField.text?.append(input)
                return true
            }
            textField.text?.append(input)
            return false
        
    }
        } else {
            if Int(textField.text!) == nil && textField.text! != "*" && textField.text! != " " {
                if textField != cardHolderTextField {
                let alertMessage = UIAlertController.init(title: "Your Entry is invalid", message: "", preferredStyle: .alert)
                let okay = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                alertMessage.addAction(okay)
                self.present(alertMessage, animated: true, completion: nil)
                textField.text = ""
                return true
                } else {
                    return true
                }
            }else {
                if textField.text == " " && textField == cardHolderTextField {
                    return true
                }
                return false
            
        }
        }
    }
    
    
   // Checking the values for CVV fields
    
    @IBAction func checkingRightValues(_ sender: Any) {
        /*      this three line reset the format of the label and textField when the
                user is editing to correct the error (if there`s one ) */
                
                cvvLbl.text = "CVV"
                cvvLbl.textColor = .darkGray
               resettingTextFieldToOriginaFormat(textField:creditCardCVV)
          //#######################################################################
        if creditCardCVV.text!.count <= 3 {
        checkingforNumbers(textField: creditCardCVV)
        }else {
            creditCardCVV.text!.removeLast()
        }
        
    }
    
    
    
    
    func checkingforNumbers(textField: UITextField)-> Bool{
        
        /* this handles inputs when you are using the simulator cause you can use tha actual
        keyboard, I developed this project using my phone and on the phone the right keyboard comes up  */
        if DidDeleteChars(inThisTxtField: textField) == false {
        if textField.text != "" {
            if messageToTheUserIfNotAnumber(textField: textField){
              
                    return false
            }else {
            
                return true
            }
        }
        return true
        } else if textField == cardHolderTextField && countingToAllowDeleteaction >= 18 {
            return false
        }else {
            return true
        }
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let paymentConfirm = segue.destination as? paymentConfirmationVC{
            if scrollViewtohide.alpha == 1{
            paymentConfirm.creditCardNumber = creditCardTextField.text!
            paymentConfirm.cardHolder = cardHolderTextField.text!
            } else {
                paymentConfirm.username = usernameTxtField.text!
                paymentConfirm.cardHolder = usernameTxtField.text!
            }
    }
    }
    
    @IBAction func proceedToConfirm (_ sender: Any) {
        if scrollViewtohide.alpha == 1 {
            isValidUntilCOkay(textField: validUntilTextField, writeTheMessageIn: validUntilLbl)
            isCvvDataOkay(textField: creditCardCVV, writeTheMessageIn: cvvLbl)
            isCreditCardNumberDataOkay(textField: creditCardTextField, writeTheMessageIn: creditCardLbl)
            isCardHolderDataOkay(textField: cardHolderTextField, writeTheMessageIn: cardHolderLbl)
        if isValidUntilCOkay(textField: validUntilTextField, writeTheMessageIn: validUntilLbl) && isCvvDataOkay(textField: creditCardCVV, writeTheMessageIn: cvvLbl) && isCreditCardNumberDataOkay(textField: creditCardTextField, writeTheMessageIn: creditCardLbl) && isCardHolderDataOkay(textField: cardHolderTextField, writeTheMessageIn: cardHolderLbl) {
            performSegue(withIdentifier: "theWayToConfirmation", sender: self)
            
        }
        } else {
            
         isTxtFieldOkay(textField: usernameTxtField, writeTheMessageIn: usernameLbl)
            isTxtFieldOkay(textField: passwordTxtField, writeTheMessageIn: passwordLbl)
            if isTxtFieldOkay(textField: usernameTxtField, writeTheMessageIn: usernameLbl) && isTxtFieldOkay(textField: passwordTxtField, writeTheMessageIn: passwordLbl){
            performSegue(withIdentifier: "theWayToConfirmation", sender: self)
            }
        }
  
    }
    
    
 // the following functions add and define the tool bar in the textFields impuViews.
// I came up with this solution cause in those field where just number are allowed on iphone just a numeric pinpad will come up, with out any return key, then i added this tool bar woth three btn.
    
    func addingToolBar(inThisTextField: UITextField) -> UIToolbar{
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        //understanding if the device run on dark or light mode and
        // changing the color of the btns accordingly:
        if traitCollection.userInterfaceStyle == .light {
        toolBar.tintColor = .darkGray
        } else {
            toolBar.tintColor = .white
        }
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
    
    /* I used the scrollview option to practise a new thing and I realized that i did not have so much space that way to place a datePicker, then I uunderstood i could used a datePiker as a inputView for the related textView, the function is the following: */
    
    func makingDatePickerInputView(inThisTextField: UITextField) {
         let formatter = DateFormatter()
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 220, width: self.view.frame.size.width, height: 216))
        let minimumdate = Date() + 86400
        datePicker.minimumDate = minimumdate // minimum date set for tomorrow
        datePicker.maximumDate = minimumdate + 126230400 // max set five years from tomorrow
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        formatter.dateFormat = "MM-yyyy"
        inThisTextField.inputView = self.datePicker
        inThisTextField.inputAccessoryView = self.addingToolBar(inThisTextField: inThisTextField)
    
        
    }
    
    
    /* object-c functions building the TollBar button for my inputviews :
    they will be three Done btn Cancel btn and clear btn
     the functionality of the btns depends on the TextField, the textFieldsCollection is an array of the textfield of the mainViewController, i used this with a for loop to select the right option for the right TextField*/
    
    @objc func doneHasBeenTapped(){
        
        let textFieldsCollection = [creditCardTextField, validUntilTextField, creditCardCVV, cardHolderTextField, passwordTxtField, usernameTxtField]
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
        let textFieldsCollection = [creditCardTextField, validUntilTextField, creditCardCVV, cardHolderTextField, passwordTxtField, usernameTxtField]
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
        let textFieldsCollection = [creditCardTextField, validUntilTextField, creditCardCVV, cardHolderTextField, passwordTxtField, usernameTxtField]
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
    
//    i really did not understand how to use the following methods
    
    
//   @IBAction func didReturnTappedpasswordTxtField(_ sender: Any){
//        if textFieldShouldReturn(passwordTxtField){
//            passwordTxtField.resignFirstResponder()
//        }
 // }
//@IBAction func didReturnTappedusernameTxtField(_ sender: Any){
//        if textFieldShouldReturn(usernameTxtField){
//            usernameTxtField.resignFirstResponder()
//       }
//    }
    
    @IBAction func cardHolderNameIsEditing(_ sender: Any){
        /*      this three line reset the format of the label and textField when the
                user is editing to correct the error (if there`s one ) */
                
        cardHolderLbl.text = "Card Holder"
         cardHolderLbl.textColor = .darkGray
        resettingTextFieldToOriginaFormat(textField:cardHolderTextField)
        //########################################################
         if  textFieldShouldBeginEditing(cardHolderTextField) {
            countingToAllowDeleteactionInCardHolderTextField = cardHolderTextField.text!.count
        }else{
            
            switch cardHolderTextField.text!.count  {
            case 1, 0:
                cardHolderTextField.text = ""
                countingToAllowDeleteactionInCardHolderTextField = 0
            default:
                cardHolderTextField.text!.removeLast()
                 countingToAllowDeleteactionInCardHolderTextField -= 1
            }
        }
    }
    
    @IBAction func findingTheCreditCardBrend(_ sender: Any) {
/*      this three line reset the format of the label and textField when the
        user is editing to correct the error (if there`s one ) */
        
        creditCardLbl.text = "Credit Card Number"
        creditCardLbl.textColor = .darkGray
       resettingTextFieldToOriginaFormat(textField:creditCardTextField)
  //#######################################################################
        var newValue = ""
        
        if textFieldShouldBeginEditing(creditCardTextField){
             if creditCardTextField.text == "" {
                 creditCardTextField.leftViewMode = .never
                 newValue = secureInputwithAnotherChar(TextField: creditCardTextField)
                whichcreditcard(forUserInput: newValue, textField: creditCardTextField)
             } else {
                 newValue = secureInputwithAnotherChar(TextField: creditCardTextField)
                whichcreditcard(forUserInput: newValue, textField: creditCardTextField)

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

       func DidDeleteChars(inThisTxtField: UITextField) -> Bool {
        
        if inThisTxtField != cardHolderTextField{
        if countingToAllowDeleteaction >= inThisTxtField.text!.count {
            return true
        }else {
            return false
        }
        
        } else if inThisTxtField == cardHolderTextField {
            if countingToAllowDeleteactionInCardHolderTextField > inThisTxtField.text!.count{
                
                return true
            }else {
                return false
            }
        }
        return true
    }

    // secureInputwithAnotherChar V 1.0 11/24/20 it works with Mastercard Discover and Visa, Amex format has not been implemented yet
    // secureInputwithAnotherChar V 1.1 12/6/20 it works with Mastercard Discover Visa and Amex
    /**
     The secureInputwithAnotherChar is the core function to secure the input besides
     the last four digits of the credit card. it works with other functions in orther to secure and guarnted the outcome
     
      - parameter TextField: is the place where the input takes place. The user will put the credit Card number in, and the latter will be secured with "*" apart from the last four digits.
       
      - returns  : a String variable storing the Credit Card Number from the user, this variable will be use in onther functions like whichcreditcard to obtain the credit Card brend.
     
       this method works with DidDeleteChars, creditCardTypeWith16numbers:
       DidDeleteChars(inThisTxtField: UITextField) - > Bool {}, will return true when backSpace on the nkeyboard has been tapped and false when it wil not be the case. creditCardTypeWith16numbers -> Bool will return true when the credit card bred is one between MasterCard, Visa, or Discover
                                            
                               
     */

    public func secureInputwithAnotherChar(TextField: UITextField)-> String{

        
        if DidDeleteChars(inThisTxtField: TextField) && creditCardTypeWith16numbers(forThisIDNumber: storingValues) {
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
        } else if DidDeleteChars(inThisTxtField: TextField) && creditCardTypeWith16numbers(forThisIDNumber: storingValues) == false{
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
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return true
//    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if checkingforNumbers(textField: textField) && textField == cardHolderTextField {
            return false
        }else if checkingforNumbers(textField: textField) == false && textField == cardHolderTextField {
            return true
        }else if checkingforNumbers(textField: textField) && stopInputIfcreditCardNumberHasTheMaxlenght(textField: textField) {
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

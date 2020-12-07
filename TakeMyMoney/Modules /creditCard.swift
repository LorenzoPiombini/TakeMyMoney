//
//  creditCard.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 12/2/20.
//

import Foundation
import UIKit

public var storingValues = ""
public var countingToAllowDeleteaction = 0
public var countingToAllowDeleteactionInCardHolderTextField = 0 
public var didBackSpaceSelect = false

    
    // error handling functions too be called within the IBAction proceed to confirm
func formattingTextFieldForError(textField: UITextField){
    textField.layer.masksToBounds = true
    textField.layer.borderColor = #colorLiteral(red: 0.9611155507, green: 0.02745098062, blue: 0, alpha: 1)
    textField.layer.borderWidth = 1.0
}
public func resettingTextFieldToOriginaFormat(textField: UITextField){
    textField.layer.masksToBounds = true
    textField.textColor = .darkGray
    textField.layer.cornerRadius = 10
    textField.clipsToBounds = true
    textField.borderStyle = .line
    textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    textField.backgroundColor = .white
 
}
public     func isCreditCardNumberDataOkay(textField: UITextField, writeTheMessageIn: UILabel) -> Bool{
        if textField.text!.count < 19 && amex(UserInput: storingValues) == false   {
            formattingTextFieldForError(textField: textField)
            writeTheMessageIn.text! += " is wrong or missing"
            writeTheMessageIn.textColor = #colorLiteral(red: 0.9611155507, green: 0.02745098062, blue: 0, alpha: 1)
            return false
        }else {
            return true
    }
    }
        
    public    func isCvvDataOkay(textField: UITextField, writeTheMessageIn: UILabel)-> Bool {
            if textField.text!.count < 3 {
                formattingTextFieldForError(textField: textField)
                writeTheMessageIn.text! += " is wrong"
                writeTheMessageIn.textColor = #colorLiteral(red: 0.9611155507, green: 0.02745098062, blue: 0, alpha: 1)
                return false
            }else {
                return true
            }
        }
        
   public  func isValidUntilCOkay(textField: UITextField, writeTheMessageIn: UILabel) -> Bool {
            if textField.text == "" {
                formattingTextFieldForError(textField: textField)
                writeTheMessageIn.text = "Exp. date is missing"
                writeTheMessageIn.textColor = #colorLiteral(red: 0.9611155507, green: 0.02745098062, blue: 0, alpha: 1)
                return false
            }else {
                return true
            }
        }
   
    public func isCardHolderDataOkay(textField: UITextField, writeTheMessageIn: UILabel) -> Bool {
        if textField.text!.contains(" ") == false {
            formattingTextFieldForError(textField: textField)
            writeTheMessageIn.text! += " is wrong"
            writeTheMessageIn.textColor = #colorLiteral(red: 0.9611155507, green: 0.02745098062, blue: 0, alpha: 1)
            return false
        }else {
            return true
        }
    }


public func isTxtFieldOkay(textField: UITextField, writeTheMessageIn: UILabel) -> Bool {
    if textField.text! == "" {
        formattingTextFieldForError(textField: textField)
        if writeTheMessageIn.text! == "Username" || writeTheMessageIn.text! == "Password"
        {
        writeTheMessageIn.text! += " is missing"
        writeTheMessageIn.textColor = #colorLiteral(red: 0.9611155507, green: 0.02745098062, blue: 0, alpha: 1)
        }
        return false
    } else {
        return true
    }
}
// functions to checl the cc brand
    
public func amex(UserInput: String) -> Bool {
    if UserInput.hasPrefix("34") || UserInput.hasPrefix("37"){
        return true
    } else {
        return false
    }
}

public func discover (UserInput: String) -> Bool {
    if UserInput.hasPrefix("6011") || UserInput.hasPrefix("68"){
        return true
    } else
    {
        return false
    }
    
}

public func visa(UserInput: String) -> Bool {
    if UserInput.hasPrefix("4") {
        return true
    } else {
        return false
    }
}

public func masterCard(UserInput: String)->Bool {
    if UserInput.hasPrefix("51") || UserInput.hasPrefix("52") || UserInput.hasPrefix("53") || UserInput.hasPrefix("54") ||
        UserInput.hasPrefix("55") {
        return true
               
    } else {
        return false
    }
}
    
    


public func formattingTheCreditCardSecuredNumberWithSpace(CreditCardTextField: UITextField){
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


public func creditCardTypeWith16numbers(forThisIDNumber: String)->Bool {
    if masterCard(UserInput: forThisIDNumber ) || visa(UserInput: forThisIDNumber) || discover(UserInput: forThisIDNumber){
        return true
    }else {
        return false
    }
}
//putting the Credit Card brand image in place on the left side of the textField
public func whichcreditcard(forUserInput:String, textField: UITextField) {
    if masterCard(UserInput: forUserInput) {
        textField.leftViewMode = .always
        let imageView = UIImageView()
        let Image = UIImage(named: "mc_symbol_opt_45_3x.png")
        imageView.image = Image
        textField.leftView = imageView
        
    }else if visa(UserInput: forUserInput){
        textField.leftViewMode = .always
        let imageView = UIImageView()
        let image = UIImage(named: "visa.png")
        imageView.image = image
        textField.leftView = imageView
    }else if discover(UserInput: forUserInput){
        textField.leftViewMode = .always
        let imageView = UIImageView()
        let image = UIImage(named: "discover.png")
        imageView.image = image
        textField.leftView = imageView
    }else if amex(UserInput: forUserInput) {
        textField.leftViewMode = .always
        let imageView = UIImageView()
        let image = UIImage(named: "amex.png")
        imageView.image = image
        textField.leftView = imageView
    }
    
}


           
//this function gives a Bool value: if the credit card number is complete, the user won`t be allowed to enter any inputs

public func stopInputIfcreditCardNumberHasTheMaxlenght(textField: UITextField) -> Bool {
if textField.text!.count == 20 && creditCardTypeWith16numbers(forThisIDNumber: storingValues) {
    return true
}else if textField.text!.count == 18 && (creditCardTypeWith16numbers(forThisIDNumber: storingValues)) == false {
    return true
}else {
    return false
}
}


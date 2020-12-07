//
//  paymentConfirmationVC.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 12/2/20.
//

import UIKit

class paymentConfirmationVC: UIViewController {
 
    var creditCardNumber: String = ""
    var cardHolder: String = ""
    var username: String = ""
    
    @IBOutlet weak var CardHolderlblL:UILabel!
    @IBOutlet weak var creditCardDataNumber:UILabel!
    @IBOutlet weak var imageAtThetop:UIImageView!
    @IBOutlet weak var imageCreditCardBrend: UIImageView!
    
    func creditCardBrandinTheView() -> UIImage{
        
        if masterCard(UserInput: storingValues) {
        
            creditCardDataNumber.text = "Mastercard ending \( formattingTheCreditCardNumber(number: creditCardNumber))"
        return UIImage(named: "mc_symbol_opt_45_3x.png")!
       
        
    }else if visa(UserInput: storingValues){
        
        creditCardDataNumber.text = "Visa ending \( formattingTheCreditCardNumber(number: creditCardNumber))"
       return UIImage(named: "visa.png")!
        
    }else if discover(UserInput: storingValues){
    
        creditCardDataNumber.text = "Discover ending \( formattingTheCreditCardNumber(number: creditCardNumber))"
        return UIImage(named: "discover.png")!
        
    }else if amex(UserInput: storingValues) {
       
        creditCardDataNumber.text = "Amex ending \( formattingTheCreditCardNumber(number: creditCardNumber))"
       return UIImage(named: "amex.png")!
      
    }
        creditCardDataNumber.text = "\(username)@paypal.com"
        return UIImage(named: "paypal .png" )!
    }
    
    
    
    @IBAction func dissimisingTheView(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func  formattingTheCreditCardNumber(number: String) -> String{
        var stringNumber = number
        for _ in stringNumber{
            if  let index2 = stringNumber.firstIndex(of: " "){
                stringNumber.remove(at: index2)
            }else if let index = stringNumber.firstIndex(of: "*"){
                stringNumber.remove(at: index)
            }
        }
        return stringNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCreditCardBrend.image = creditCardBrandinTheView()
        CardHolderlblL.text = cardHolder
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func payTapped(_ sender:Any){
        let allertMessage = UIAlertController.init(title: "Sorry!", message: "Your payment has failed", preferredStyle: .alert)
        let actionOkay = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        allertMessage.addAction(actionOkay)
        present(allertMessage, animated: true, completion: nil)
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

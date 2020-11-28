//
//  drawingCreditCArdLogo.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/19/20.
//

import UIKit

class drawingCreditCArdLogo: UITextField {

    
    var toolBar = UIToolbar()
    // overriding the leftViewRect of the UITextView in order to fit the UIImage containing the credit card logo
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let height = self.frame.size.height
        let width = self.frame.size.width / 6
        let newSize = CGRect(x: 10, y: height / 20, width: width , height: height)
        return newSize
        
    }
    
    
    override  func awakeFromNib() {
        formattingTextField()
        
    }
    
    // just copy the other UIViewText format
    func formattingTextField (){
        textColor = .darkGray
        layer.cornerRadius = 10
        clipsToBounds = true
        borderStyle = .line
        backgroundColor = .white
        var toolBar = addingToolBar()
        
        
    }
    
    
    
    func addingToolBar()-> UIToolbar{
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
    
    let Done = UIBarButtonItem(title: "Done", style: .plain, target: self, action:#selector(self.doneHasBeenTapped))
    let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(self.cancelHasBeenTapped))
    
    toolBar.setItems([Done, cancel], animated: true)
    toolBar.isUserInteractionEnabled = true
    self.toolBar.isHidden = false
        return toolBar
    }
    
    
    @objc func doneHasBeenTapped(){
       
       
        inputView?.isHidden = true
       self.toolBar.isHidden = true
       
       self.resignFirstResponder()
       
   }
  @objc func cancelHasBeenTapped (){
      inputView?.isHidden = true
       self.toolBar.isHidden = true
   self.resignFirstResponder()

   }
        /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

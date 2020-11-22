//
//  drawingCreditCArdLogo.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/19/20.
//

import UIKit

class drawingCreditCArdLogo: UITextField {

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
        
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

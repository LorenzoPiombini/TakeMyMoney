//
//  proceedToConfirmStyle.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 12/6/20.
//

import UIKit
@IBDesignable
class proceedToConfirmStyle: UIButton {
    override  func prepareForInterfaceBuilder() {
        styleBtn()
    }
    
    override func awakeFromNib() {
        styleBtn()
    }
    
    func styleBtn(){
        layer.cornerRadius = 25
        clipsToBounds = true
        layer.borderWidth = 1.0
        backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.4470588235, blue: 0.937254902, alpha: 1)
        tintColor = #colorLiteral(red: 0.8431372549, green: 0.8784313725, blue: 0.9764705882, alpha: 1)
        
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

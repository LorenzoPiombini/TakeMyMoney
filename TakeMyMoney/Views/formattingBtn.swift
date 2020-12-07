//
//  formattingBtn.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 12/5/20.
//

import UIKit

@IBDesignable
class formattingBtn: UIButton {

    override  func prepareForInterfaceBuilder() {
        styleBtn()
    }
    
    override  func awakeFromNib() {
        
        if isTouchInside {
            isSelected = true
        }
        styleBtn()
    }
    
    func styleBtn(){
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.4470588235, blue: 0.937254902, alpha: 1)
        tintColor = #colorLiteral(red: 0.8431372549, green: 0.8784313725, blue: 0.9764705882, alpha: 1)
    
    }
    
}

//
//  textFieldformatter.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/18/20.
//

import UIKit

@IBDesignable
class textFieldformatter: UITextField {

    override func prepareForInterfaceBuilder() {
        formattingTextField()
    }
    
    override  func awakeFromNib() {
        formattingTextField()
    }
    
    func formattingTextField (){
        textColor = .darkGray
        layer.cornerRadius = 10
        clipsToBounds = true
        borderStyle = .line
        backgroundColor = .white
        
        
    }
    
    
}

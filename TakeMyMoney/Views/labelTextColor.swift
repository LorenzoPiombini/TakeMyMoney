//
//  labelTextColor.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/18/20.
//

import UIKit
@IBDesignable
class labelTextColor: UILabel {

    override  func prepareForInterfaceBuilder() {
        darkGrayColorForThexLbl()
    }
    override  func awakeFromNib() {
        darkGrayColorForThexLbl()
    }

    
    func darkGrayColorForThexLbl(){
        textColor = .darkGray
    }
}

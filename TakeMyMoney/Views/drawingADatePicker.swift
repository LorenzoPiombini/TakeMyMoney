//
//  drawingADatePicker.swift
//  TakeMyMoney
//
//  Created by Lorenzo piombini on 11/26/20.
//

import UIKit

class drawingADatePicker: UIScrollView {

    
    
    
    override func draw(_ rect: CGRect) {
        creatingTheDatePicker()
        
    }
    
    func creatingTheDatePicker(){
        var pickDate: UIDatePicker = UIDatePicker()
        pickDate.datePickerMode = .date
        pickDate.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 220)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

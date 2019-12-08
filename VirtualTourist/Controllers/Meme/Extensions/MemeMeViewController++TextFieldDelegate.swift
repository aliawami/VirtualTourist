//
//  MemeMeViewController++TextFieldDelegate.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit

extension MemeMeViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "top".uppercased() || textField.text == "bottom".uppercased(){
            textField.text = ""
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            if textField.tag == 500{
                textField.text = "top".uppercased()
            }else{
                textField.text = "bottom".uppercased()
            }
        }
        else{
            shareButton.isEnabled = true
            
        }
        textField.resignFirstResponder()
        return true
    }
    
}

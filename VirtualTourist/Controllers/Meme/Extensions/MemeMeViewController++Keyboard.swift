//
//  MemeMeViewController++Keyboard.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit

extension MemeMeViewController{
    
    //Create keyboard notification for showing and hiding
    func keyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappeard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //relocated the y origin of the main view to show the bottom text field
    @objc func keyboardWillShow(_ notification: Notification){
        
        view.frame.origin.y = -self.keyboardHeight(notification)
    }
    
    //Return the view to ist orginal y if it has been changed
    @objc func keyboardWillDisappeard(_ notification:Notification){
        if  view.frame.origin.y != 0{
            view.frame.origin.y += self.keyboardHeight(notification)
        }
    }
    
    
    //Get the height o the keyboard
    func keyboardHeight(_ notification: Notification)-> CGFloat{
        guard let userInfo = notification.userInfo else{ return  0}
        
        let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        if self.bottomTextField.isFirstResponder == true{
            return keyboardSize.height
        }else{
            return 0
        }
        
    }
    
    
    //End the noficiation observers for the keyboard
    func keyboardNoificationDismiss(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

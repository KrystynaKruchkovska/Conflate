//
//  UIViewController + Alert.swift
//  Conflate
//
//  Created by Mac on 12/28/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertWithError(_ error:Error?, secondAlertAction:UIAlertAction? = nil) {
        let errorTitle = Constants.Alerts.errorAlertTitle
        
        guard let message = error?.localizedDescription  else {
            self.showAlertInternalError()
            return
        }
        
        showAlert(message, title: errorTitle, handler: nil,secondAlertAction: secondAlertAction)
    }
    
    
    func showAlert(_ message:String, title:String, handler:((_
        action:UIAlertAction?)->())?, secondAlertAction:UIAlertAction? = nil){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,  handler: handler))
       
        if let secondAction = secondAlertAction {
            alert.addAction(secondAction)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertInternalError() {
        self.showAlert(Constants.Strings.internal_error, title: Constants.Alerts.errorAlertTitle, handler: nil)
    }
    
}

func createErrorWithMessage(_ message:String) -> Error {
    return NSError(domain:"", code:-1, userInfo:[ NSLocalizedDescriptionKey: message])
}

func createInternalError() -> Error {
    return createErrorWithMessage(Constants.Strings.internal_error)
}

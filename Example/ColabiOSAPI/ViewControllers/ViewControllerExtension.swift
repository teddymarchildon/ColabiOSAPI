//
//  ViewControllerExtension.swift
//  DemoApp
//
//  Created by Lucy Zhang on 1/31/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func presentLoadingIndicator() -> UIAlertController{
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        return alert
    }
}

extension UIAlertController{
    
    func removeLoadingIndicator(){
        self.view.subviews.forEach({ (view) in
            if view.isKind(of: UIActivityIndicatorView.self){
                view.removeFromSuperview()
            }
        })
    }
    
    func addDismissalButton(){
        self.addAction(UIAlertAction(title: "OK", style: .default, handler: self.dismissSelf))
    }
    
    func dismissSelf(action:UIAlertAction){
        self.dismiss(animated: false, completion: nil)
    }
}

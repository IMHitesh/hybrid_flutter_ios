//
//  File.swift
//
//
//  Created by Hitesh Surani on 17/01/23.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, subTitle: String){
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

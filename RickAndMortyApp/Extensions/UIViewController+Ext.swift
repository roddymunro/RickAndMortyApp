//
//  UIViewController+Ext.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-20.
//

import UIKit

extension UIViewController {
    func presentErrorAlert(error: ErrorModel) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            alertViewController.addAction(.init(title: "OK", style: .default))
            
            self.present(alertViewController, animated: true)
        }
    }
}

//
//  UIViewController.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 22.11.2020.
//

import UIKit

extension UIViewController {
    func showError(error: Error) {
        let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default))
        
        present(alertController, animated: true)
    }
}

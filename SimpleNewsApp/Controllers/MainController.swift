//
//  MainController.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import UIKit

class MainController: UIViewController {
    let customView = MainView()
    
    override func loadView() {
        view = customView
    }
}

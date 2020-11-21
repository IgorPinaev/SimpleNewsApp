//
//  MainController.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import UIKit

class MainController: UIViewController {
    let customView = MainView()
    let articlesService = ArticlesService()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesService.getArticles(from: 1)
    }
}

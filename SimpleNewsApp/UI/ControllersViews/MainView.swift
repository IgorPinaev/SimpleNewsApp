//
//  MainView.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import UIKit

class MainView: UIView {
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainView {
    func configureView() {
        backgroundColor = .white
        
        addSubview(tableView)
        tableView.fillParent()
        
        tableView.register(ArticleTableCell.self, forCellReuseIdentifier: ArticleTableCell.reuseId)
        tableView.tableFooterView = UIView()
    }
}

//
//  MainView.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import UIKit

class MainView: UIView {
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
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
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        addSubview(tableView)
        tableView.fillParent()
        
        tableView.refreshControl = refreshControl
        
        tableView.register(ArticleTableCell.self, forCellReuseIdentifier: ArticleTableCell.reuseId)
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        tableView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        tableView.tableFooterView = spinner
    }
}

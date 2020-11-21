//
//  ArticleTableCell.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import UIKit

class ArticleTableCell: UITableViewCell {
    static var reuseId: String { String(describing: self) }
    
    private var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(_ article: Article) {
        titleLabel.text = article.title
    }
}

private extension ArticleTableCell {
    func setupLayouts() {
        addSubview(titleLabel)
        titleLabel.fillParent(8)
        titleLabel.numberOfLines = 0
    }
}

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
    private var descriptionLabel = UILabel()
    private var articleImage = CacheImageView(frame: .zero)
    private var grayView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        makeConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(_ article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.desc
        articleImage.setupImage(from: article.urlToImage)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        articleImage.cancelTask()
        articleImage.image = nil
    }
}

private extension ArticleTableCell {
    func addSubviews() {
        [articleImage, grayView, titleLabel, descriptionLabel].forEach(addSubview)
    }
    
    func makeConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        grayView.fillParent()
        articleImage.fillParent()
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configureView() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .white
        
        articleImage.contentMode = .scaleToFill
        
        grayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
}

//
//  CacheImageView.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 22.11.2020.
//

import UIKit

class CacheImageView: UIImageView {
    static var cache = NSCache<NSString, UIImage>()
    private var task: URLSessionTask?
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(from link: String?) {
        guard let link = link else {
            return setImage()
        }
        
        if let cacheImage = CacheImageView.cache.object(forKey: link as NSString) {
            return setImage(image: cacheImage)
        }
        
        activityIndicator.startAnimating()
        
        loadImage(link)
    }
    
    func cancelTask() {
        task?.cancel()
    }
}

private extension CacheImageView {
    func setupActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func loadImage(_ link: String) {
        guard let url = URL(string: link) else {
            return setImage()
        }
        
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                    self?.setImage()
                    return
            }
            
            CacheImageView.cache.setObject(image, forKey: link as NSString)

            self?.setImage(image: image)
        }
        task?.resume()
    }
    
    func setImage(image: UIImage? = UIImage(named: "placeholder")) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.image = image
        }
    }
}

//
//  ArticlesService.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation

class ArticlesService {
    private let apiService = ApiService()
    
    func getArticles(from page: Int) {
        apiService.loadData(with: NewsApi.getNews(page: page), type: ArticlesResponse.self) { result in
            switch result {
            case let .success(response):
                print(response)
                
            case let .failure(error):
                print(error)
            }
        }
    }
}

//
//  ArticlesService.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation

class ArticlesService {
    private let apiService = ApiService()
    
    func getArticles(from page: Int, completion: @escaping (Error?) -> Void) {
        apiService.loadData(with: NewsApi.getNews(page: page), type: ArticlesResponse.self) { result in
            switch result {
            case let .success(response):
                let context = CoreDataService.instance.bcgContext
                
                context.perform {
                    if page == 1 {
                        do {
                            try context.clearData(in: Article.self)
                        } catch {
                            completion(error)
                        }
                    }
                    
                    response.articles.forEach { Article.from($0, context: context) }
                    
                    context.saveContext {
                        CoreDataService.instance.context.saveContext()
                    }
                    
                    completion(nil)
                }
            case let .failure(error):
                completion(error)
            }
        }
    }
}

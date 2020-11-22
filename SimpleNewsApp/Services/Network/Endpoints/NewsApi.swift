//
//  NewsApi.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation

enum NewsApi {
    case getNews(page: Int)
}

extension NewsApi: EndpointProtocol {
    var host: String {
        return "newsapi.org"
    }
    
    var path: String {
        return "/v2/everything"
    }
    
    var params: [String : String] {
        switch self {
        case .getNews(let page):
            return [
                "page": page.description,
                "q": "Apple",
                "language": "en",
                "sortBy": "publishedAt"
            ]
        }
        
    }
    
    var headers: [String : String] {
        return ["X-Api-Key": "009bf23be7fa455095ae15b261ac5e0a"]
    }
}

//
//  Article.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation

struct Article: Decodable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
}

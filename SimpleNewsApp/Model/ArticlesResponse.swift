//
//  ArticlesResponse.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation

struct ArticlesResponse: Decodable {
    let articles: [Article]
}

//
//  ApiError.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

struct APIError: Decodable {
    let code: String
    let message: String
}

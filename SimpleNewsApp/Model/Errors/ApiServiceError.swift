//
//  ApiServiceError.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation

enum ApiServiceError: LocalizedError {
    case invalidURL
    case dataNil
    case decodingError
    case unknownError
    case customError(error: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Ошибка при отправке запроса"
        case .dataNil:
            return "Данные отсутствуют"
        case .decodingError:
            return "Ошибка при обработке запроса"
        case .unknownError:
            return "Неизвестная ошибка"
        case let .customError(error):
            return error
        }
    }
}

//
//  ApiServiceError.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation

enum ApiServiceError: String, LocalizedError {
    case invalidURL = "Ошибка при отправке запроса"
    case dataNil = "Данные отсутствуют"
    case decodingError = "Ошибка при обработке запроса"
    case unknownError = "Неизвестная ошибка"
    case customError(error: String) = error
}

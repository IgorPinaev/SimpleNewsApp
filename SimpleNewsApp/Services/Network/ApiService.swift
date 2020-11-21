//
//  ApiService.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import Foundation

class ApiService {
    private let jsonDecoder: JSONDecoder
    
    init(decoder: JSONDecoder? = nil) {
        if let decoder = decoder {
            jsonDecoder = decoder
        } else {
            jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
        }
    }
    
    func loadData<T: Decodable>(with endpoint: EndpointProtocol, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = buildRequest(with: endpoint) else {
            return completion(Result.failure(ApiServiceError.invalidURL))
        }
        
        executeRequest(request: request, type: type, completion: completion)
    }
}

private extension ApiService {
    func buildRequest(with endpoint: EndpointProtocol) -> URLRequest? {
        var components = URLComponents()
        
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        
        components.queryItems = endpoint.params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
        endpoint.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
    }
    
    func executeRequest<T: Decodable>(request: URLRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                return completion(Result.failure(error))
            }
            
            guard let data = data else {
                return completion(Result.failure(ApiServiceError.dataNil))
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) {
                guard let parsedData = self?.parse(from: data, with: type) else {
                    return completion(Result.failure(ApiServiceError.decodingError))
                }
                
                completion(Result.success(parsedData))
            } else {
                guard let apiError = self?.parse(from: data, with: APIError.self) else {
                    completion(Result.failure(ApiServiceError.unknownError))
                    return
                }
                completion(Result.failure(ApiServiceError.customError(error: apiError.message)))
            }
        }.resume()
    }
    
    func parse<T:Decodable>(from data: Data, with type: T.Type) -> T? {
        return try? jsonDecoder.decode(type, from: data)
    }
}

//
//  EndpointProtocol.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var params: [String: String] { get }
    var headers: [String: String] { get }
}
extension EndpointProtocol {
    var scheme: String {
        return "https"
    }
}

//
//  NetworkManager.swift
//  async-await-githup
//
//  Created by yasin on 26.11.2023.
//

import Foundation


class NetworkManager {
   static let shared = NetworkManager()
    
    func getUser() async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/dalkilicyasin"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url) // Burdaki yapıya bak ilki Data ikincisi URLResponse type nı gönderiyor
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidURL
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedValue = try decoder.decode(GitHubUser.self, from: data)
            return decodedValue
        } catch {
            throw GHError.invalidData
        }
    }
    
    private init(){
    }
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}


//
//  NetworkManager.swift
//  Rick and Morty
//
//  Created by Maksim  on 27.04.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(dataType: T.Type, from url: String?, with completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let urlString = url else {
            completion(.failure(.invalidURL))
            return }
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: T.self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(_):
                    completion(.failure(.decodingError))
                }
            }
    }
    private init() {}
}

/*
 private func fetchData(from url: String) {
     NetworkManager.shared.fetchData(dataType: RickAndMorty.self, from: url) { data in
         switch data {
         case .success(_):
             <#code#>
         case .failure(_):
             <#code#>
         }
     }
     
 }
}
 */

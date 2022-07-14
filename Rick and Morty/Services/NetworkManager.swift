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

class ImageManager {
    static var shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data,URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "NOOO")
                return
            }
            DispatchQueue.main.async {
                completion(data,response)
            }

        }.resume()
    }
}

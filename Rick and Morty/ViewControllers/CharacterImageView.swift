//
//  CharacterImageView.swift
//  Rick and Morty
//
//  Created by Maksim  on 04.05.2022.
//

import UIKit

class CharacterImageView: UIImageView {
    
    // MARK: - Data caching
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        if let cachedImage = getCachedImage(from: imageUrl) {
            image = cachedImage
            return
        }
        
        ImageManager.shared.fetchImage(from: imageUrl) { [weak self] data, response in
            self?.saveDataToCashe(with: data, and: response)
            if imageUrl.lastPathComponent == response.url?.lastPathComponent {
                self?.image = UIImage(data: data)
            }
        }
    }

    private func saveDataToCashe(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedURLResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else { return nil }
        guard url.lastPathComponent == cachedResponse.response.url?.lastPathComponent else { return nil }
        return UIImage(data: cachedResponse.data)
    }
    
    // MARK: - de init
    deinit {
        print("CharacterImageView - выгружен")
    }
   
}

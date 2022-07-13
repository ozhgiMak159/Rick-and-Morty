//
//  CharacterImageView.swift
//  Rick and Morty
//
//  Created by Maksim  on 04.05.2022.
//

import Foundation
import UIKit

class CharacterImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        // Действия 2: Использования изображения из кеша
        if let cachedImage = getCachedImage(from: imageUrl) {
            image = cachedImage
            return
        }
        
        // Действия 1: Сначала загружаем картинки из сети
        ImageManager.shared.fetchImage(from: imageUrl) { data, response in
            // Сохранения картинок в кэш
            self.saveDataToCashe(with: data, and: response)
            if imageUrl.lastPathComponent == response.url?.lastPathComponent {
                print("Image from url - \(imageUrl.lastPathComponent)")
                self.image = UIImage(data: data)
            }
        }
    }

    // Функция по сохранению картинок в кэш
    private func saveDataToCashe(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedURLResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
    }
    
    // Функция по поиску картинок в кеше
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else { return nil }
        guard url.lastPathComponent == cachedResponse.response.url?.lastPathComponent else { return nil }
        print("Image from cache - \(url.lastPathComponent)")
        return UIImage(data: cachedResponse.data)
    }
    
    
    
        
}

//
//  EpisodesDetailViewController.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit

class EpisodesDetailViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var episodeDescription: UILabel!
    
    var episode: Episode!
    private var characters: [Character] = [] {
        didSet {
            if characters.count == episode.characters.count {
                characters = characters.sorted { $0.id < $1.id }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setCharacters() {
        episode.characters.forEach { characterURL in
            NetworkManager.shared.fetchData(dataType: Character.self, from: characterURL) { result in
                switch result {
                case .success(let ok):
                    self.characters.append(ok)
                case .failure(_):
                    print("1")
                }
            }
        }
    }

}

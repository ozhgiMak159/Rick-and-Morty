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
        setCharacters()
        
        title = episode.episode
        episodeDescription.text = episode.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailInfoPersonViewController else { return }
        detailsVC.character = sender as? Character
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

extension EpisodesDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOne",for: indexPath) as! TableViewCell
        
        let characterURL = episode.characters[indexPath.row]
        
        NetworkManager.shared.fetchData(dataType: Character.self, from: characterURL) { result in
            switch result {
            case .success(let data):
                cell.configure(with: data)
            case .failure(_):
                print("12")
            }
        }
        
        return cell
    }
}

extension EpisodesDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let character = characters[indexPath.row]
        performSegue(withIdentifier: "showCharacter", sender: character)
    }

}

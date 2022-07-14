//
//  EpisodesTableViewController.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit

class EpisodesTableViewController: UITableViewController {
    
    // MARK: - Public and Private properties
    var character: Character!
    private var episodes: [Episode] = []
    
    // MARK: - de init
    deinit {
        print("EpisodesTableViewController - выгружен")
    }

    // MARK: - Life Cycle EpisodesTableViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableVC()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeDetailsVC = segue.destination as? EpisodesDetailViewController else { return }
        episodeDetailsVC.episode = sender as? Episode
    }
    
    // MARK: - Private method
    private func settingsTableVC() {
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .black
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.barTintColor = .white
    }
}

// MARK: - Table view data source
extension EpisodesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.episode.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTwo", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let episodeURL = character.episode[indexPath.row]
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
        
        NetworkManager.shared.fetchData(dataType: Episode.self, from: episodeURL) { [weak self] result in
            switch result {
            case .success(let episode):
                self?.episodes.append(episode)
                content.text = episode.name
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        performSegue(withIdentifier: "ShowEpisode", sender: episode)
    }
    
}

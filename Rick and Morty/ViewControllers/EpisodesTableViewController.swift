//
//  EpisodesTableViewController.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit

class EpisodesTableViewController: UITableViewController {
    
    var character: Character!
    var episodes: [Episode] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.episode.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    private func settingsTableVC() {
        tableView.rowHeight = 70
        tableView.backgroundColor = UIColor(
            red: 93/255,
            green: 93/255,
            blue: 93/255,
            alpha: 1)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(
            red: 93/255,
            green: 93/255,
            blue: 93/255,
            alpha: 0.9)
    }
    
    

}

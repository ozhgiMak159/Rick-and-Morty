//
//  MainTableViewController.swift
//  Rick and Morty
//
//  Created by Maksim  on 27.04.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Private properties
    private var rickAndMorty: RickAndMorty?
    private var filteredCharacter: [Character] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.rowHeight = 65
        
        fetchData(from: Link.rickAndMortyApi.rawValue)

    }

    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        isFiltering ? filteredCharacter.count : rickAndMorty?.results.count ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        return cell
//    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }

    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(dataType: RickAndMorty.self, from: url) { dataWithApi in
            switch dataWithApi {
            case .success(let rickAndMortyData):
                self.rickAndMorty = rickAndMortyData
                print(rickAndMortyData)
               // self.tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
    }

}

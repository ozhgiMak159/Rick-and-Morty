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
        settingsTableVC()
        
        fetchData(from: Link.rickAndMortyApi.rawValue)
        
        setupSearchController()
        setupNavigationBar()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacter.count : rickAndMorty?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOne", for: indexPath) as! TableViewCell
        let character = isFiltering ? filteredCharacter[indexPath.row] : rickAndMorty?.results[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let character = isFiltering ? filteredCharacter[indexPath.row] : rickAndMorty?.results[indexPath.row] else { return }
        guard let detailVC = segue.destination as? DetailInfoPersonViewController else { return }
        detailVC.character = character
    }
    
    
    @IBAction func upData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: rickAndMorty?.info.next ?? "")
        : fetchData(from: rickAndMorty?.info.prev ?? "")
    }
    
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        guard let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField else { return }
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        textField.textColor = .white
    }
    
    private func settingsTableVC() {
        tableView.backgroundColor = .black
        tableView.rowHeight = 80
    }
    
    
    // данный метод устанавливает навигационный бар и убирает белую полоску при скролле
    private func setupNavigationBar() {
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance // вот эти методы
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance // и эти
        }
    }
    

    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(dataType: RickAndMorty.self, from: url) { dataWithApi in
            switch dataWithApi {
            case .success(let rickAndMortyData):
                self.rickAndMorty = rickAndMortyData
                self.tableView.reloadData()
            case .failure(_):
                print("error") 
            }
        }
    }

    
}

// MARK: - UISearchResultsUpdating
extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacter = rickAndMorty?.results.filter { character in
            character.name.lowercased().contains(searchText.lowercased())
        } ?? []
        tableView.reloadData()
    }
    
}

//
//  DetaliPersonViewController.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit
import AlamofireImage

class DetailInfoPersonViewController: UIViewController {

    // MARK: - IB Outlet
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imagePerson: CharacterImageView!
    
    // MARK: - Public properties
    var character: Character!
   
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imagePerson.layer.cornerRadius = imagePerson.frame.width / 2
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let episodesVC = navigationVC.topViewController as? EpisodesTableViewController else { return }
        episodesVC.character = character
    }
    
    // MARK: - Private Methods
   private func setModel() {
        descriptionLabel.text = character.description
        imagePerson.fetchImage(from: character.image)
        title = character.name
    }
    
    private func setupNavBar() {
        guard let topItem = navigationController?.navigationBar.topItem else { return }
        topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}


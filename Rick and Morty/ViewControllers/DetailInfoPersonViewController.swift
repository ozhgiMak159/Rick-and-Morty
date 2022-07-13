//
//  DetaliPersonViewController.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit
import AlamofireImage


// Рефакторинг

class DetailInfoPersonViewController: UIViewController {

    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imagePerson: CharacterImageView!
    
    var character: Character!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        add()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imagePerson.layer.cornerRadius = imagePerson.frame.width / 2
    }
    
   private func add() {
        descriptionLabel.text = character.description
        imagePerson.fetchImage(from: character.image)
    }
    
    private func setupNavBar() {
        guard let topItem = navigationController?.navigationBar.topItem else { return }
        topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        title = character.name
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let episodesVC = navigationVC.topViewController as? EpisodesTableViewController else { return }
        episodesVC.character = character
        
    }
    
    
    
}


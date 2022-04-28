//
//  DetaliPersonViewController.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit
import AlamofireImage

class DetailInfoPersonViewController: UIViewController {

    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imagePerson: UIImageView! {
        didSet {
            imagePerson.layer.cornerRadius = imagePerson.frame.width / 2
        }
    }
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add()
    }
    
    private func add() {
        title = character.name
        descriptionLabel.text = character.description
        
        guard let imageUrl = URL(string: character.image) else { return }
        imagePerson.af.setImage(withURL: imageUrl)
        
        // Метод уберающий "Back"
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let episodesVC = navigationVC.topViewController as? EpisodesTableViewController else { return }
        episodesVC.character = character
    }
}



//    override func layoutSubviews() {
//        super.layoutSubviews()
//        imagePerson.layer.cornerRadius = imagePerson.frame.width / 2
//    }

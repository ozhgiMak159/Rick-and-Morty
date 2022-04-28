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
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add()

    }
    
    private func add() {
        title = character.name
        descriptionLabel.text = character.description
        
        guard let imageUrl = URL(string: character.image) else { return }
        imagePerson.af.setImage(withURL: imageUrl)
        
    }

  
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    

}

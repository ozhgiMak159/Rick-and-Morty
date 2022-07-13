//
//  DetailedTableViewCell.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit
import AlamofireImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
            characterImageView.backgroundColor = .white
        }
    }

    func configure(with character: Character?) {
        nameLabel.text = character?.name
        
        characterImageView.fetchImage(from: character?.image ?? "")
    }
    
    
    override func prepareForReuse() {
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
    }
    
}

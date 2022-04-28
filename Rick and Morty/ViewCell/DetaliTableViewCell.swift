//
//  DetailedTableViewCell.swift
//  Rick and Morty
//
//  Created by Maksim  on 28.04.2022.
//

import UIKit
import AlamofireImage

class DetailedTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
            characterImageView.backgroundColor = .white
        }
    }
    
    func configure(with character: Character?) {
        nameLabel.text = character?.name
    }
    
    
}

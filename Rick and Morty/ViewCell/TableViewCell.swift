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
    @IBOutlet weak var characterImageView: CharacterImageView!
    
    
    override func layoutSubviews() {
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.clipsToBounds = true
        characterImageView.backgroundColor = .white
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
    }
     
    
    func configure(with character: Character?) {
        nameLabel.text = character?.name
        
        characterImageView.fetchImage(from: character?.image ?? "")
    }
    
    
}

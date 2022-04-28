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
    @IBOutlet weak var characterImageView: UIImageView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.clipsToBounds = true
        characterImageView.backgroundColor = .white
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
    }
    
    func configure(with character: Character?) {
        nameLabel.text = character?.name
        
        guard let imageUrl = URL(string: character?.image ?? "") else { return }
        characterImageView.af.setImage(withURL: imageUrl)
    }
    
    
}

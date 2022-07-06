//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var PersonName: UILabel!
    
    @IBOutlet weak var LastLocationLabel: UILabel!
    @IBOutlet weak var PersonType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ Character: Result) {
        
        guard let image = Character.image else { return }
        guard let imageUrl = URL(string: image) else { return }
        guard let name = Character.name else { return }
        guard let location = Character.location else { return }
        guard let alive = Character.status else { return }
        guard let gender = Character.species else { return }
        characterImageView.kf.setImage(with: imageUrl)
        PersonName.text = name
        LastLocationLabel.text = location.name
        PersonType.text = alive.rawValue + " - " + gender.rawValue
        characterImageView.layer.masksToBounds = true
        characterImageView.layer.cornerRadius = 15
        
    }
}

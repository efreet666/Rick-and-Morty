//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import UIKit

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
    
    static func setup(_ Character: Result) {
        let viewCell = CharacterTableViewCell()
        
        guard let image = Character.image else { return }
        guard let imageUrl = URL(string: image) else { return }
        guard let name = Character.name else { return }
        guard let location = Character.location else { return }
        
        viewCell.characterImageView.
        
    }
}

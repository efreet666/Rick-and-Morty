//
//  EpisodeTableViewCell.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 06.07.2022.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeNameLabel: UILabel!
    
    @IBOutlet weak var episodeIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func setup(_ episode: Episode){
        episodeNameLabel.text = episode.name
        episodeIdLabel.text = episode.episode
    }
}

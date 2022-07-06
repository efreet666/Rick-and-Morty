//
//  DetailViewController.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 05.07.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var character: Result?
    
    @IBOutlet weak var UIImageViewOutlet: UIImageView!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var statusLabelOutlet: UILabel!
    
    @IBOutlet weak var LocationLabelOutlet: UILabel!
    @IBOutlet weak var firstSeenLabelOutlet: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        fetchCharactersData()
        setupCharacterData()
    }
   
    
    func fetchCharactersData() {
        print(character)
        guard let currentCharacter = character else { return }
        let characterURL = "https://rickandmortyapi.com/api/character/\(String(describing: currentCharacter.id))"
        
        DispatchQueue.main.async {
            NetworkManager.fetchData(characterURL) { [weak self] result in
                switch result {
                case .success(let characterData):
                    if let result = characterData.results {
                        self?.character = result.first
                        print(self?.character as Any)
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
        }
        
    }
    
    func setupCharacterData() {
        guard let characterImage = character?.image else { return }
        guard let characterImageURl = URL(string: characterImage) else { return }
        UIImageViewOutlet.kf.setImage(with: characterImageURl)
        UIImageViewOutlet.contentMode = .scaleAspectFill
        
        guard let characterName = character?.name else { return }
        guard let characterStatus = character?.gender else { return }
        guard let characterLocation = character?.location else { return }
        guard let characterOrigin = character?.origin else { return }
        
        nameLabelOutlet.text = characterName
        statusLabelOutlet.text = characterStatus.rawValue
        LocationLabelOutlet.text = characterLocation.name
        firstSeenLabelOutlet.text = characterOrigin.name
        
        
    }

}

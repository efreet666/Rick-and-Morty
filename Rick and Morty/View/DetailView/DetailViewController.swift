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
    var characterEpisodes = [Episode]()
    
    // MARK: - Outlets
    @IBOutlet weak var episodeTableView: UITableView!
    @IBOutlet weak var UIImageViewOutlet: UIImageView!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var statusLabelOutlet: UILabel!
    @IBOutlet weak var LocationLabelOutlet: UILabel!
    @IBOutlet weak var firstSeenLabelOutlet: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.episodeTableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        self.episodeTableView.delegate = self
        self.episodeTableView.dataSource = self
        
        guard let currentCharacter = character else { return }
        fetchEpisodes(episodeUrl: "https://rickandmortyapi.com/api/episode/\(getCharacterEpisodes(currentCharacter))")
        
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }
    
func fetchEpisodes(episodeUrl: String) {
    
        DispatchQueue.main.async {
            NetworkManager.fetchEpisode(episodeURL: episodeUrl) { [weak self] result in
                switch result {
                case .success(let episodeData):
                    self?.characterEpisodes.append(episodeData)
                    print(self?.characterEpisodes)
                    self?.setupCharacterData()
                    self?.episodeTableView.reloadData()
                case .failure(let err):
                    print(err)
                }
            }
        }
        
    }
    func getCharacterEpisodes(_ character: Result) -> String {
        var characterEpisodes = ""
        guard let episodes = character.episode else { return characterEpisodes }

        characterEpisodes = episodes.map {$0.components(separatedBy: "/").last!}.reduce("", +)
        print(characterEpisodes)
        return characterEpisodes
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

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(characterEpisodes.count)
        return characterEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.episodeTableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as! EpisodeTableViewCell
        cell.setup(characterEpisodes[indexPath.row])
        return cell
    }
    
    
    
}

//
//  DetailViewController.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 05.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    func fetchCharactersData() {
        DispatchQueue.main.async {
            NetworkManager.fetchData(NetworkManager.allPersonURL) { [weak self] result in
                switch result {
                case .success(let infoDataModel):
                    if let result = infoDataModel.results {
                        for character in result{
                            self?.characters.append(character)
                            
                            self?.tableViewOutlet.reloadData()
                        }
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
        }
        
    }

}

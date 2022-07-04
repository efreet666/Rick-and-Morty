//
//  MainViewController.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    var characters = [Result]()
    let controller = Controller()
    let network = NetworkManager()
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewOutlet.delegate = self
        self.tableViewOutlet.dataSource = self
        
       
        self.tableViewOutlet.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        fetchCharactersData()
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewOutlet.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        cell.setup(character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyB = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = storyB.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
        let character = characters[indexPath.row]
        vc.id = character.id
    }
    
}

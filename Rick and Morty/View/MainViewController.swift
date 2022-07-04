//
//  MainViewController.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    let controller = Controller()
    let network = NetworkManager()
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewOutlet.delegate = self
        self.tableViewOutlet.dataSource = self
        
       
        self.tableViewOutlet.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        controller.requestData()
        
    }
    
    func updateTableView() {
        tableViewOutlet.reloadData()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewOutlet.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        let character = network.characters[indexPath.row]
        CharacterTableViewCell.setup(character)
        return cell
    }
    
    
    
}

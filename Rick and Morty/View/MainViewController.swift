//
//  MainViewController.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    let controller = Controller()
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewOutlet.register(CharacterTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        controller.requestData()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller.network.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewOutlet.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CharacterTableViewCell
        let character = controller.network.characters[indexPath.row]
        CharacterTableViewCell.setup(character)
        return cell
    }
    
    
    
}

//
//  MainViewController.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import UIKit


class MainViewController: UIViewController {
    var pageInfo: Info?
    var characters = [Result]()
    let controller = Controller()
    let network = NetworkManager()
    
    var isLoading = false
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewOutlet.delegate = self
        self.tableViewOutlet.dataSource = self
        
       
        self.tableViewOutlet.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        fetchCharactersData(NetworkManager.allPersonURL)
    }
    
    func fetchCharactersData(_ url: String) {
        DispatchQueue.main.async {
            NetworkManager.fetchData(url) { [weak self] result in
                switch result {
                case .success(let infoDataModel):
                    if let result = infoDataModel.results {
                        for character in result{
                            self?.characters.append(character)
                            print(self?.characters as Any)
                            self?.tableViewOutlet.reloadData()
                        }
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
        }
        
    }
    
    func loadMoreData() {
        
            self.isLoading = true
            DispatchQueue.global().async { [weak self] in
                guard let info = self?.pageInfo else { return }
                guard let nextPage = info.next else {
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.tableViewOutlet.reloadData()
                    }
                    return
                }
                print(nextPage)

                self?.fetchCharactersData(nextPage)
                DispatchQueue.main.async {
                    self?.tableViewOutlet.reloadData()
                    self?.isLoading = false
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
        
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        
        let character = characters[indexPath.row]
        print(character)
        vc.character = character
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - view.frame.size.height

        if (offsetY > contentHeight), !isLoading {
            loadMoreData()
        }
        loadMoreData()
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
                let lastElement = characters.count - 1
                if indexPath.row == lastElement {
                    loadMoreData()
                    }
        loadMoreData()
            }
    
}

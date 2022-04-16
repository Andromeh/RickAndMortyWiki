//
//  ViewController.swift
//  Rick and Morty Wiki
//
//  Created by Белозеров Константин on 15.04.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var characters = [CharacterInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON  {
            self.tableView.reloadData()
        }
        
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        
        cell.nameLabel.text = characters[indexPath.row].name
        cell.genderLabel.text = characters[indexPath.row].gender
        cell.speciesLabel.text = characters[indexPath.row].species
        //cell.backgroundColor = .
        let urlString = characters[indexPath.row].image
        let url = URL(string: urlString)
        cell.characterImage.downloaded(from: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterViewController {
            destination.character = characters[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
        
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://rickandmortyapi.com/api/character")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
                do {
                    let decodedData = try JSONDecoder().decode(CharacterList.self, from: data!)
                    
                    self.characters.append(contentsOf: decodedData.results)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                } catch {
                    print("JSON error \(error)")
                }
            
        }
        .resume()
    }
    
}


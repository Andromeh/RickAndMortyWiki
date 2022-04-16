//
//  CharacterViewController.swift
//  Rick and Morty Wiki
//
//  Created by Белозеров Константин on 15.04.2022.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class CharacterViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var character: CharacterInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.image = UIImage(named: "Background2.png")
                
        nameLabel.text = character?.name
        speciesLabel.text = character?.species
        genderLabel.text = character?.gender
        statusLabel.text = character?.status
        placeLabel.text = character?.location.name
        
        if let episodesCount = character?.episode.count {
            episodesLabel.text = "\(episodesCount)"
        }
        
        let urlString = character?.image
        let url = URL(string: urlString!)
        
        characterImage.downloaded(from: url!)

    }
    

    

}

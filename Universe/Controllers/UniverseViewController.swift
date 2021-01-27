//
//  UniverseViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class UniverseViewController: UIViewController, ChangesDelegate {
     
     @IBOutlet weak var galaxiesCollection: UICollectionView!
     private var universe: Universe?
     private let reuseIdentifier = "galaxyCell"
     
     override func viewDidLoad() {
          super.viewDidLoad()
          universe = Universe(name: "Universe", blackHoleChangingPointMass: Double.random(in: 0...100), blackHoleChangingPointRadius: Double.random(in: 0...100))
          universe?.delegate = self
          galaxiesCollection.delegate = self
          galaxiesCollection.dataSource = self
     }
     
     func updateChanges() {
          DispatchQueue.main.async { [weak self] in
               self?.galaxiesCollection.reloadData()
          }
     }
     
}

extension UniverseViewController: UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          universe!.galaxies.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let galaxy = universe!.galaxies[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! GalaxyCollectionViewCell
          
          cell.name.text = galaxy.name
          cell.age.text = "Age: \(galaxy.age)"
          cell.type.text = "Type: \(galaxy.type!.rawValue)"
          
          cell.layer.cornerRadius = cell.frame.height / 5
          
          return cell
     }
     
}

extension UniverseViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let galaxy = universe!.galaxies[indexPath.row]
          
          let galaxyViewController = GalaxyViewController()
          galaxyViewController.galaxy = galaxy
          navigationController?.pushViewController(galaxyViewController, animated: true)
     }
}

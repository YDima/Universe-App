//
//  PlanetViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class PlanetViewController: UIViewController {
     
     @IBOutlet weak var satelitesCollection: UICollectionView!
     var planet: Planet?
     private let reuseIdentifier = "sateliteCell"
     
     var delegate: StateMachineProtocol?
     
     override func viewDidLoad() {
          super.viewDidLoad()
          satelitesCollection.delegate = self
          satelitesCollection.dataSource = self
     }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          self.title = "Satelites"
     }
     
     override func didMove(toParent parent: UIViewController?) {
          super.didMove(toParent: parent)

          if parent == nil {
               delegate?.notifyStateMachine(source: self, .Back, planet!)
          }
     }
     
     func updateChanges() {
          DispatchQueue.main.async { [weak self] in
               self?.satelitesCollection.reloadData()
          }
     }
     
}

extension PlanetViewController: UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          planet?.satelites.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let skyObject = planet!.satelites[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SkyObjectCollectionViewCell
          
          cell.name.text = skyObject.name
          cell.mass.text = "Mass: \(skyObject.mass)"
          
          cell.layer.cornerRadius = cell.frame.height / 5
          
          return cell
     }
     
}

extension PlanetViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
     }
}

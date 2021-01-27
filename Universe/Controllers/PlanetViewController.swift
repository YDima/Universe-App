//
//  PlanetViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class PlanetViewController: UIViewController {
     
     @IBOutlet weak var satelitesCollection: UICollectionView!
     var galaxy: Galaxy?
     private let reuseIdentifier = "skyObjectCell"
     
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
               delegate?.notifyStateMachine(source: self, .Back)
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
          galaxy?.skyObjects.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let skyObject = galaxy!.skyObjects[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SkyObjectCollectionViewCell
          
          cell.name.text = skyObject.name
          cell.age.text = "Age: \(skyObject.age)"
          cell.mass.text = "Mass: \(skyObject.mass)"
          
          cell.layer.cornerRadius = cell.frame.height / 5
          
          return cell
     }
     
}

extension PlanetViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
     }
}

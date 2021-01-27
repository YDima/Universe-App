//
//  GalaxyViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class GalaxyViewController: UIViewController, ChangesDelegate {
     
     @IBOutlet weak var skyObjectsCollection: UICollectionView!
     var galaxy: Galaxy?
     private let reuseIdentifier = "skyObjectCell"
     
     var delegate: StateMachineProtocol?
     
     override func viewDidLoad() {
          super.viewDidLoad()
          skyObjectsCollection.delegate = self
          skyObjectsCollection.dataSource = self
     }
     
     func updateChanges() {
          DispatchQueue.main.async { [weak self] in
               self?.skyObjectsCollection.reloadData()
          }
     }
     
}

extension GalaxyViewController: UICollectionViewDataSource {
     
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

extension GalaxyViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let skyObject = galaxy!.skyObjects[indexPath.row]
          
     }
}


//
//  GalaxyViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class GalaxyViewController: UIViewController {
     
     @IBOutlet weak var skyObjectsCollection: UICollectionView!
     var universeViewController: UniverseViewController?
     var galaxy: Galaxy?
     private let reuseIdentifier = "skyObjectCell"
     
     var delegate: StateMachineProtocol?
     
     required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          skyObjectsCollection.delegate = self
          skyObjectsCollection.dataSource = self
          galaxy?.changesDelegate = self
     }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          self.title = "Solar systems"
     }
     
     override func didMove(toParent parent: UIViewController?) {
          super.didMove(toParent: parent)
          
          if parent == nil {
               delegate?.notifyStateMachine(source: self, .Back, galaxy!)
          }
     }
     
}

//MARK: - Changes update

extension GalaxyViewController: ChangesDelegate {
     func updateChanges() {
          DispatchQueue.main.async { [weak self] in
               self?.skyObjectsCollection.reloadData()
          }
     }
}

//MARK: - UICollectionViewDataSource

extension GalaxyViewController: UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          galaxy!.skyObjects.count
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

//MARK: - UICollectionViewDelegate

extension GalaxyViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let skyObject = galaxy!.skyObjects[indexPath.row]
          delegate?.notifyStateMachine(source: self, .Next, skyObject)
     }
}


//
//  PlanetViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class PlanetViewController: UIViewController, ChangesDelegate {
    
    @IBOutlet weak var satelitesCollection: UICollectionView!
    weak var planet: Planet?
    weak var coordinator: Coordinator?
    private let reuseIdentifier = "sateliteCell"
    
    weak var delegate: StateMachineProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        satelitesCollection.dataSource = self
        planet?.delegate = self
        self.delegate = coordinator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Satelites"
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if parent == nil {
            delegate?.notifyStateMachine(source: self, .Back, planet!, coordinator: coordinator!)
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
        planet!.satelites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let satelite = planet!.satelites[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SateliteCollectionViewCell
        
        cell.name.text = satelite.name
        cell.mass.text = "Mass: \(satelite.planetMass)"
        
        cell.layer.cornerRadius = cell.frame.height / 5
        
        return cell
    }
    
}


//
//  UniverseViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class UniverseViewController: UIViewController {
    
    @IBOutlet weak var galaxiesCollection: UICollectionView!
    private var universe: Universe?
    var coordinator = Coordinator()
    private let reuseIdentifier = "galaxyCell"
    
    weak var delegate: StateMachineProtocol?
    
    /*
     Mentor's comment:
     It's not a mistake, but next time try to group similar logic below in a generic function
     ---
     And in general it's a bad decision to keep all these view controllers in memory all the time.
     In relatively simple app like this one it's fine, but in bigger ones this may lead to very poor
     memory performance.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        universe = Universe(name: "Universe", blackHoleChangingPointMass: Double.random(in: 0...100), blackHoleChangingPointRadius: Double.random(in: 0...100))
        universe?.delegate = self
        galaxiesCollection.delegate = self
        galaxiesCollection.dataSource = self
        coordinator.setup()
        self.delegate = coordinator
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Galaxies"
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
}

//MARK: - Changes delegate

extension UniverseViewController: ChangesDelegate {
    func updateChanges() {
        DispatchQueue.main.async { [weak self] in
            self?.galaxiesCollection.reloadData()
        }
    }
}

////MARK: - State machine
//
//extension UniverseViewController {
//    func setup() {
//
//        self.universeStateMachine[.Galaxies] = [
//            .Next: .SolarSystems
//        ]
//
//        self.universeStateMachine[.SolarSystems] = [
//            .Next: .PlanetsAndStar,
//            .Back: .Galaxies
//        ]
//
//        self.universeStateMachine[.PlanetsAndStar] = [
//            .Next: .Satelites,
//            .Back: .SolarSystems
//        ]
//
//        self.universeStateMachine[.Satelites] = [
//            .Back: .PlanetsAndStar
//        ]
//
//        //        self.universeViewController.delegate = self
//        //        self.galaxyViewController.delegate = self
//        //        self.solarSystemViewController.delegate = self
//        //        self.planetViewController.delegate = self
//    }
//}

/*
 Mentor's comment:
 Navigation inside an app isn't a great fit for state machine pattern. This kind of logic is usually
 implemented inside a Coordinator object.
 */
// See Coordinator.swift

//MARK: - UICollectionView

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

//MARK: - UICollectionViewDelegate

extension UniverseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galaxy = universe!.galaxies[indexPath.row]
        delegate?.notifyStateMachine(source: self, .Next, galaxy, coordinator: coordinator)
    }
}

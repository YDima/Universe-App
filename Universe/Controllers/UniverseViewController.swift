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
     
     var delegate: StateMachineProtocol?
     
     var universeStateMachine = SimpleStateMachine<UniverseStates, Actions>(initialState: .Galaxies)
     
     lazy var universeViewController: UniverseViewController = UIStoryboard(name: "Main", bundle: Bundle(for: UniverseViewController.self)).instantiateViewController(withIdentifier: "UniverseViewController") as! UniverseViewController
     lazy var galaxyViewController: GalaxyViewController = UIStoryboard(name: "Main", bundle: Bundle(for: GalaxyViewController.self)).instantiateViewController(withIdentifier: "GalaxyViewController") as! GalaxyViewController
     lazy var solarSystemViewController: SolarSystemViewController = UIStoryboard(name: "Main", bundle: Bundle(for: SolarSystemViewController.self)).instantiateViewController(withIdentifier: "SolarSystemViewController") as! SolarSystemViewController
     lazy var planetViewController: PlanetViewController = UIStoryboard(name: "Main", bundle: Bundle(for: PlanetViewController.self)).instantiateViewController(withIdentifier: "PlanetViewController") as! PlanetViewController
     
     override func viewDidLoad() {
          super.viewDidLoad()
          universe = Universe(name: "Universe", blackHoleChangingPointMass: Double.random(in: 0...100), blackHoleChangingPointRadius: Double.random(in: 0...100))
          universe?.delegate = self
          galaxiesCollection.delegate = self
          galaxiesCollection.dataSource = self
          
          setup()
     }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          self.title = "Galaxies"
          self.navigationItem.setHidesBackButton(true, animated: false)
     }
     
     func updateChanges() {
          DispatchQueue.main.async { [weak self] in
               self?.galaxiesCollection.reloadData()
          }
     }
}

//MARK: - State machine

extension UniverseViewController {
     func setup() {
          
          universeStateMachine[.Galaxies] = [
               .Next: .SolarSystems
          ]
          
          universeStateMachine[.SolarSystems] = [
               .Next: .PlanetsAndStar,
               .Back: .Galaxies
          ]
          
          universeStateMachine[.PlanetsAndStar] = [
               .Next: .Satelites,
               .Back: .SolarSystems
          ]
          
          universeStateMachine[.Satelites] = [
               .Back: .PlanetsAndStar
          ]
          
          universeViewController.delegate = self
          galaxyViewController.delegate = self
          solarSystemViewController.delegate = self
          planetViewController.delegate = self
     }
}

// This is where the magic happens!
extension UniverseViewController: StateMachineProtocol {
     
     func notifyStateMachine(source: UIViewController, _ event: Actions) {
          
          if let nextState = universeStateMachine.transition(event: event) {
               
               if event == .Back { return }
               
               self.navigationController?.isNavigationBarHidden = false
               
               switch nextState {
                    case .Galaxies:
                         self.navigationController?.pushViewController(universeViewController, animated: true)
                    case .SolarSystems:
                         self.navigationController?.pushViewController(galaxyViewController, animated: true)
                    case .PlanetsAndStar:
                         self.navigationController?.pushViewController(solarSystemViewController, animated: true)
                    case .Satelites:
                         self.navigationController?.pushViewController(planetViewController, animated: true)
               }
          }
     }
}

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

extension UniverseViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          print(3)
          notifyStateMachine(source: self, .Next)
     }
}

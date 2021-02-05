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
     
     var universeStateMachine = UniverseStateMachine<UniverseStates, Actions>(initialState: .Galaxies)
    /*
     Mentor's comment:
     It's not a mistake, but next time try to group similar logic below in a generic function
     ---
     And in general it's a bad decision to keep all these view controllers in memory all the time.
     In relatively simple app like this one it's fine, but in bigger ones this may lead to very poor
     memory performance.
     */
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
          
          self.universeStateMachine[.Galaxies] = [
               .Next: .SolarSystems
          ]
          
          self.universeStateMachine[.SolarSystems] = [
               .Next: .PlanetsAndStar,
               .Back: .Galaxies
          ]
          
          self.universeStateMachine[.PlanetsAndStar] = [
               .Next: .Satelites,
               .Back: .SolarSystems
          ]
          
          self.universeStateMachine[.Satelites] = [
               .Back: .PlanetsAndStar
          ]
          
          self.universeViewController.delegate = self
          self.galaxyViewController.delegate = self
          self.solarSystemViewController.delegate = self
          self.planetViewController.delegate = self
     }
}

/*
 Mentor's comment:
 Navigation inside an app isn't a great fit for state machine pattern. This kind of logic is usually
 implemented inside a Coordinator object.
 */
extension UniverseViewController: StateMachineProtocol {
     
     func notifyStateMachine(source: UIViewController, _ event: Actions,_ universeObject: UniverseObject) {
          
          if let nextState = universeStateMachine.transition(event: event) {
               
               if event == .Back {
                    return
               }
               
               switch nextState {
                    case .Galaxies:
                         self.navigationController?.pushViewController(universeViewController, animated: true)
                    case .SolarSystems:
                         galaxyViewController.galaxy = universeObject as! Galaxy
                         self.navigationController?.pushViewController(galaxyViewController, animated: true)
                    case .PlanetsAndStar:
                         solarSystemViewController.solarSystem = universeObject as! SolarSystem
                         self.navigationController?.pushViewController(solarSystemViewController, animated: true)
                    case .Satelites:
                         planetViewController.planet = universeObject as! Planet
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

//MARK: - UICollectionViewDelegate

extension UniverseViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let galaxy = universe!.galaxies[indexPath.row]
          notifyStateMachine(source: self, .Next, galaxy)
     }
}

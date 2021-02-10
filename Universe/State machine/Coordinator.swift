//
//  Coordinator.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 10.2.21.
//

import UIKit

class Coordinator: StateMachineProtocol {
    
    var universeStateMachine = UniverseStateMachine<UniverseStates, Actions>(initialState: .Galaxies)
    
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
    }
    
    func notifyStateMachine(source: UIViewController, _ event: Actions,_ universeObject: UniverseObject, coordinator: Coordinator) {
        if let nextState = universeStateMachine.transition(event: event) {
            
            if event == .Back {
                return
            }
            
            switch nextState {
                case .Galaxies:
                    let universeViewController: UniverseViewController = .instantiate(from: "Main", identifier: "UniverseViewController")
                    source.navigationController?.pushViewController(universeViewController, animated: true)
                    
                case .SolarSystems:
                    let galaxyViewController: GalaxyViewController = .instantiate(from: "Main", identifier: "GalaxyViewController")
                    galaxyViewController.galaxy = (universeObject as! Galaxy)
                    galaxyViewController.coordinator = coordinator
                    source.navigationController?.pushViewController(galaxyViewController, animated: true)
                    
                case .PlanetsAndStar:
                    let solarSystemViewController: SolarSystemViewController = .instantiate(from: "Main", identifier: "SolarSystemViewController")
                    solarSystemViewController.solarSystem = (universeObject as! SolarSystem)
                    solarSystemViewController.coordinator = coordinator
                    source.navigationController?.pushViewController(solarSystemViewController, animated: true)
                    
                case .Satelites:
                    let planetViewController: PlanetViewController = .instantiate(from: "Main", identifier: "PlanetViewController")
                    planetViewController.planet = (universeObject as! Planet)
                    planetViewController.coordinator = coordinator
                    source.navigationController?.pushViewController(planetViewController, animated: true)
            }
        }
    }
    
}

extension UIViewController {
    static func instantiate<T: UIViewController>(from storyboard: String, identifier: String) -> T {
        return UIStoryboard(name: storyboard, bundle: Bundle(for: T.self)).instantiateViewController(withIdentifier: identifier) as! T
    }
}

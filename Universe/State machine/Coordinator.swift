//
//  Coordinator.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 10.2.21.
//

import UIKit

class Coordinator: StateMachineProtocol {
    
    var universeStateMachine = UniverseStateMachine<UniverseStates, Actions>(initialState: .Galaxies)
    
    lazy var universeViewController: UniverseViewController = UIStoryboard(name: "Main", bundle: Bundle(for: UniverseViewController.self)).instantiateViewController(withIdentifier: "UniverseViewController") as! UniverseViewController
    
    lazy var galaxyViewController: GalaxyViewController = UIStoryboard(name: "Main", bundle: Bundle(for: GalaxyViewController.self)).instantiateViewController(withIdentifier: "GalaxyViewController") as! GalaxyViewController
    
    lazy var solarSystemViewController: SolarSystemViewController = UIStoryboard(name: "Main", bundle: Bundle(for: SolarSystemViewController.self)).instantiateViewController(withIdentifier: "SolarSystemViewController") as! SolarSystemViewController
    
    lazy var planetViewController: PlanetViewController = UIStoryboard(name: "Main", bundle: Bundle(for: PlanetViewController.self)).instantiateViewController(withIdentifier: "PlanetViewController") as! PlanetViewController
    
    func setup() {
        universeViewController.delegate = self
        galaxyViewController.delegate = self
        solarSystemViewController.delegate = self
        planetViewController.delegate = self
        
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
                    universeViewController.navigationController?.pushViewController(universeViewController, animated: true)
                    
                case .SolarSystems:
                    galaxyViewController.galaxy = (universeObject as! Galaxy)
                    galaxyViewController.coordinator = coordinator
                    universeViewController.navigationController?.pushViewController(galaxyViewController, animated: true)
                    
                case .PlanetsAndStar:
                    solarSystemViewController.solarSystem = (universeObject as! SolarSystem)
                    solarSystemViewController.coordinator = coordinator
                    universeViewController.navigationController?.pushViewController(solarSystemViewController, animated: true)
                    
                case .Satelites:
                    planetViewController.planet = (universeObject as! Planet)
                    planetViewController.coordinator = coordinator
                    universeViewController.navigationController?.pushViewController(planetViewController, animated: true)
            }
        }
    }
    
}

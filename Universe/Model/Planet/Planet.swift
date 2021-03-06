//
//  Planet.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

class Planet: UniverseObject {
     
     internal var name: String
     var age = 0
     var type = PlanetType.allCases.randomElement()
     var planetMass = Double.random(in: 0..<1000)
     private var temperature = Double.random(in: -1000...1000)
     private var radius = Double.random(in: 0..<100)
     weak var main: Planet?
     var satelites: [Planet] = []
     
     var delegate: ChangesDelegate?
     
     var mass: Double {
          for satelite in satelites {
            /*
             Mentor's comment:
             You mutate the field here, inside a computed property. This leads to a bug when planet's mass
             infinitely grows.
             */
               planetMass += satelite.planetMass
          }
          return planetMass
     }
     
     init(name: String) {
          self.name = name
          initializeSatelites()
     }
     
     private init(name: String, main: Planet) {
          self.name = name
          self.main = main
     }
     
}

//MARK: - Update

extension Planet {
     func updateAge() {
          self.age += 1
          
          self.delegate?.updateChanges()
     }
}

//MARK: - Planet types

extension Planet {
     enum PlanetType: String, CaseIterable {
          case gasGiant = "Gas giant"
          case superEarth = "Super Earth"
          case neptuneLike = "Neptune like"
          case terrestrial = "Terrestrial"
     }
}

//MARK: - Initializers

private extension Planet {
     func initializeSatelites() {
          let randomNumberOfSatelites = Int.random(in: 0...5)
          for sateliteNumber in 0...randomNumberOfSatelites {
               let satelite = Planet(name: "S\(sateliteNumber)", main: self)
               satelites.append(satelite)
          }
     }
}


//
//  Planet.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

class Planet {
     
     private var name: String?
     private var type = PlanetType.allCases.randomElement()
     private var mass: Double?
     private var temperature: Double?
     private var radius: Double?
     private weak var main: Planet?
     private var satelites: [Planet] = []
     
     init(name: String) {
          self.name = name
          initPlanetData()
          initializeSatelites()
     }
     
     private init(name: String, main: Planet) {
          self.name = name
          self.main = main
          initPlanetData()
     }
     
}

//MARK: - Planet types

private extension Planet {
     enum PlanetType: String, CaseIterable {
          case gasGiant = "Gas giant"
          case superEarth = "Super Earth"
          case neptuneLike = "Neptune like"
          case terrestrial = "Terrestrial"
     }
}

//MARK: - Initializers

private extension Planet {
     func initPlanetData() {
          let maxPlanetMass = 1000.0
          self.mass = Double.random(in: 0..<maxPlanetMass)
          self.radius = Double.random(in: 0..<100)
          self.temperature = Double.random(in: -1000...1000)
     }
     
     func initializeSatelites() {
          let randomNumberOfSatelites = Int.random(in: 0...5)
          for sateliteNumber in 0...randomNumberOfSatelites {
               let satelite = Planet(name: "S\(sateliteNumber)", main: self)
               satelites.append(satelite)
          }
     }
}


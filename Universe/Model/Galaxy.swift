//
//  Galaxy.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol GalaxyDelegate {
     func updateAfterGalaxiesCollision(galaxy1: Galaxy, galaxy2: Galaxy)
}

class Galaxy {
     enum GalaxyType: String {
          case spiral = "Spiral"
          case elliptical = "Elliptical"
          case lenticular = "Lenticular"
          case irregular = "Irregular"
     }
     
     private var name: String
     private var age: UInt = 0
     private let type: GalaxyType
     private var solarSystems = [SolarSystem]()
     private var blackHoles = [Star]()
     
     init(name: String, type: GalaxyType) {
          self.name = name
          self.type = type
     }
     
}

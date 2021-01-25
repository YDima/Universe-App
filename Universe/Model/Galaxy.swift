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
     
     private var name: String
     private var age: Int = 0
     private let type = GalaxyType.allCases.randomElement()
     private var solarSystems: [SolarSystem] = []
     private var blackHoles: [Star] = []
     
     init(name: String) {
          self.name = name
     }
     
}

//MARK: - Timer delegate

extension Galaxy: TimerDelegate {
     func updateAge() {
          self.age += 1
          
          
     }
}

//MARK: - Galaxy types

extension Galaxy {
     enum GalaxyType: String, CaseIterable {
          case spiral = "Spiral"
          case elliptical = "Elliptical"
          case lenticular = "Lenticular"
          case irregular = "Irregular"
     }
}


//
//  Universe.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

final class Universe {
     
     private let name: String
     private var galaxies = [Galaxy]()
     private var age: Int = 0
     var blackHoleMass: Double
     var blackHoleRadius: Double
     
     init(name: String, blackHoleMass: Double, blackHoleRadius: Double) {
          self.name = name
          self.blackHoleMass = blackHoleMass
          self.blackHoleRadius = blackHoleRadius
     }
     
     func createNewGalaxy() {
          
     }
     
     func galaxiesCollision() {
          
     }
     
}

//MARK: - Handling galaxies collision

extension Universe: GalaxyDelegate {
     func updateAfterGalaxiesCollision(galaxy1: Galaxy, galaxy2: Galaxy) {
          
     }
}

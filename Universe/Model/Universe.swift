//
//  Universe.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

class Universe {
     
     private let name: String
     private var galaxies: [Galaxy] = []
     private var age: Int = 0
     private var timer: UniverseTimer?
     
     var blackHoleChangingPointMass: Double
     var blackHoleChangingPointRadius: Double
     
     init(name: String, blackHoleChangingPointMass: Double, blackHoleChangingPointRadius: Double) {
          self.name = name
          self.blackHoleChangingPointMass = blackHoleChangingPointMass
          self.blackHoleChangingPointRadius = blackHoleChangingPointRadius
          
          timer?.startTimer()
          timer?.delegate = self
     }
}

//MARK: - Galaxies functionality

extension Universe: GalaxyDelegate {
     func createNewGalaxy() {
          let galaxy = Galaxy(name: "\(self.name)-G\(galaxies.count)", timer: timer, blackHoleChangingPointMass: blackHoleChangingPointMass, blackHoleChangingPointRadius: blackHoleChangingPointRadius)
          galaxies.append(galaxy)
     }
     
     func galaxiesCollision() {
          var oldGalaxies = galaxies.filter({$0.age >= 180})
          guard oldGalaxies.count > 1 else {
               return
          }
          oldGalaxies = Array(oldGalaxies.prefix(upTo: 2))
          oldGalaxies = oldGalaxies.sorted(by: { $0.mass > $1.mass })
          
          oldGalaxies[0].collide(with: oldGalaxies[1])
     }
     
     func updateAfterGalaxiesCollision(galaxy: Galaxy) {
          if let i = galaxies.firstIndex(where: { $0.name == galaxy.name }) {
               galaxies.remove(at: i)
          }
     }
}

//MARK: - Timer delegate

extension Universe: TimerDelegate {
     func updateAge() {
          self.age += 1
          
          if age%10 == 0 {
               createNewGalaxy()
          }
          if age%30 == 0 {
               galaxiesCollision()
          }
     }
}


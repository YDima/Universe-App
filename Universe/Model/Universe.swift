//
//  Universe.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol StarChangingPointDelegate {
     func updateStarData(_ blackHoleChangingPointMass: Double, _ blackHoleChangingPointRadius: Double)
}

class Universe {
     
     private let name: String
     private var galaxies: [Galaxy] = []
     private var age: Int = 0
     private var timer: UniverseTimer?
     
     var star_delegate: StarChangingPointDelegate?
     
     var blackHoleChangingPointMass: Double
     var blackHoleChangingPointRadius: Double
     
     init(name: String, blackHoleChangingPointMass: Double, blackHoleChangingPointRadius: Double) {
          self.name = name
          self.blackHoleChangingPointMass = blackHoleChangingPointMass
          self.blackHoleChangingPointRadius = blackHoleChangingPointRadius
          
          timer?.startTimer()
          timer?.delegate = self
          
          star_delegate?.updateStarData(self.blackHoleChangingPointMass, self.blackHoleChangingPointRadius)
     }
}

//MARK: - Galaxies functionality

extension Universe: GalaxyDelegate {
     func createNewGalaxy() {
          let galaxy = Galaxy(name: "\(self.name)-G\(galaxies.count)")
          galaxies.append(galaxy)
     }
     
     func galaxiesCollision() {
          
     }
     
     func updateAfterGalaxiesCollision(galaxy1: Galaxy, galaxy2: Galaxy) {
          
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


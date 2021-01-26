//
//  SolarSystem.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol SolarSystemDelegate {
     
}

protocol StarChangingPointDelegate {
     func updateStarData(_ blackHoleChangingPointMass: Double, _ blackHoleChangingPointRadius: Double)
}

class SolarSystem: SkyObject {
     internal var name: String
     internal var age: Int = 0
     private var star: Star
     private var planets: [Planet] = []
     private var timer: UniverseTimer?
     private let planetsNumber = Int.random(in: 0...9)
     
     var star_delegate: StarChangingPointDelegate?
     
     init(name: String, timer: UniverseTimer?, blackHoleChangingPointMass: Double, blackHoleChangingPointRadius: Double) {
          self.name = name
          self.star = Star(name: "Star")
          star_delegate = self.star
          star_delegate?.updateStarData(blackHoleChangingPointMass, blackHoleChangingPointRadius)
          self.timer = timer
          self.timer?.delegate = self
     }
}

//MARK: - Timer delegate

extension SolarSystem: TimerDelegate {
     func updateAge() {
          self.age += 1
          
          guard planets.count <= planetsNumber else {
               return
          }
          
          if age%10 == 0 {
               createNewPlanet()
          }
          
     }
}

//MARK: - Solar system functionality

private extension SolarSystem {
     func createNewPlanet() {
          let planet = Planet(name: "\(self.name)-P\(planets.count)")
          planets.append(planet)
     }
}

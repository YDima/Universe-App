//
//  SolarSystem.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol SolarSystemDelegate {
     func solarSystemBecameBlackHole(_ star: Star, _ solarSystem: SolarSystem)
}

class SolarSystem: SkyObject {
     internal var name: String
     internal var age: Int = 0
     var star: Star
     private var solarSystemMass = 0.0
     var planets: [Planet] = []
     private let planetsNumber = Int.random(in: 0...9)
     
     var mass: Double {
          for planet in planets {
               solarSystemMass += planet.mass
          }
          solarSystemMass += star.mass
          return solarSystemMass
     }
     
     var solarSystemDelegate: SolarSystemDelegate?
     var delegate: ChangesDelegate?
     
     init(name: String,_ blackHoleChangingPointMass: Double,_ blackHoleChangingPointRadius: Double) {
          self.name = name
          self.star = Star(name: "Star", blackHoleChangingPointMass, blackHoleChangingPointRadius)
          self.star.delegate = self
     }
}

//MARK: - Star delegate

extension SolarSystem: StarDelegate {
     func starBecameBlackHole(_ star: Star) {
          solarSystemDelegate?.solarSystemBecameBlackHole(star, self)
          for planet in planets {
               planet.satelites.removeAll()
          }
          planets.removeAll()
     }
}

//MARK: - Update

extension SolarSystem {
     func updateAge() {
          self.age += 1
          
          star.updateAge()
          planets.forEach {
               $0.updateAge()
          }
          self.delegate?.updateChanges()
          
          guard planets.count <= planetsNumber else {
               return
          }
          
          if self.age%10 == 0 {
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

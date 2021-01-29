//
//  Galaxy.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol GalaxyDelegate {
     func updateAfterGalaxiesCollision(galaxy: Galaxy)
}

class Galaxy: UniverseObject {
     
     var name: String
     var age: Int = 0
     private var galaxyMass = 0.0
     let type = GalaxyType.allCases.randomElement()
     var skyObjects: [SkyObject] = []
     
     var mass: Double {
          for skyObject in skyObjects {
               galaxyMass += skyObject.mass
          }
          return galaxyMass
     }
     
     var blackHoleChangingPointMass: Double
     var blackHoleChangingPointRadius: Double
     
     var delegate: GalaxyDelegate?
     var changesDelegate: ChangesDelegate?
     
     init(name: String,_ blackHoleChangingPointMass: Double,_ blackHoleChangingPointRadius: Double) {
          self.name = name
          self.blackHoleChangingPointMass = blackHoleChangingPointMass
          self.blackHoleChangingPointRadius = blackHoleChangingPointRadius
          createNewSolarSystem()
     }
     
     func collide(with galaxy: Galaxy) {
          skyObjects.append(contentsOf: galaxy.skyObjects)
          galaxy.skyObjects.removeAll()
          var skyObjectsPercents = round(Double(skyObjects.count) * 0.1)
          
          while skyObjectsPercents > 0 {
               let randomSkyObject = skyObjects.randomElement()
               if let i = skyObjects.firstIndex(where: { $0.name == randomSkyObject!.name }) {
                    skyObjects.remove(at: i)
               }
               skyObjectsPercents -= 1
          }
          
          delegate?.updateAfterGalaxiesCollision(galaxy: galaxy)
     }
}

//MARK: - Solar system delegate

extension Galaxy: SolarSystemDelegate {
     func solarSystemBecameBlackHole(_ star: Star, _ solarSystem: SolarSystem) {
          if let i = skyObjects.firstIndex(where: { $0.name == solarSystem.name }) {
               skyObjects[i] = star
               print(skyObjects[i])
          }
     }
}

//MARK: - Update

extension Galaxy {
     func updateAge() {
          self.age += 1
          
          if self.age%10 == 0 {
               createNewSolarSystem()
          }
          
          skyObjects.forEach {
               $0.updateAge()
          }
          
          self.changesDelegate?.updateChanges()
          
     }
}

//MARK: - Solar system functionality

private extension Galaxy {
     func createNewSolarSystem() {
          let solarSystem = SolarSystem(name: "\(self.name)-S\(skyObjects.count)", blackHoleChangingPointMass, blackHoleChangingPointRadius)
          skyObjects.append(solarSystem)
          solarSystem.solarSystemDelegate = self
     }
}





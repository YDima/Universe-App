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

class Galaxy {
     
     var name: String
     var age: Int = 0
     var mass: Double = 3.0
     private let type = GalaxyType.allCases.randomElement()
     private var skyObjects: [SkyObject] = []
     private var timer: UniverseTimer?
     
     var blackHoleChangingPointMass: Double
     var blackHoleChangingPointRadius: Double
     
     var delegate: GalaxyDelegate?
     
     init(name: String, timer: UniverseTimer?, blackHoleChangingPointMass: Double, blackHoleChangingPointRadius: Double) {
          self.name = name
          self.blackHoleChangingPointMass = blackHoleChangingPointMass
          self.blackHoleChangingPointRadius = blackHoleChangingPointRadius
          self.timer = timer
          self.timer?.delegate = self
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

//MARK: - Timer delegate

extension Galaxy: TimerDelegate {
     func updateAge() {
          self.age += 1
          
          if age%10 == 0 {
               createNewSolarSystem()
          }
          
     }
}

//MARK: - Solar system functionality

private extension Galaxy {
     func createNewSolarSystem() {
          let solarSystem = SolarSystem(name: "\(self.name)-S\(skyObjects.count)", timer: timer, blackHoleChangingPointMass: blackHoleChangingPointMass, blackHoleChangingPointRadius: blackHoleChangingPointRadius)
          skyObjects.append(solarSystem)
     }
}

//MARK: - Galaxy types

private extension Galaxy {
     enum GalaxyType: String, CaseIterable {
          case spiral = "Spiral"
          case elliptical = "Elliptical"
          case lenticular = "Lenticular"
          case irregular = "Irregular"
     }
}


//
//  Galaxy.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

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
     
    /* 👍
     Mentor's comment:
     This issue is present inside every entity you have, so I'll write about it only once and here.
     You must never (really never) keep delegates with a strong reference. Each time you do it, you almost 100%
     create a retain cycle thus introducing a memory leak. Your code is "free" of leaking view controllers and models
     only because you keep them deliberately (see lazy view controller properties of UniverseViewController).
     */
    
     weak var changesDelegate: ChangesDelegate?
     
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
          
        /* 👍
         Mentor's comment:
         I see no point of calling a delegate for this functionality. Take a look at the code which calls
         this (collide(with:)) method. It calls this method synchronusly, so you can safely move the line below
         there and simplify the codebase.
         */
     }
}

//MARK: - Solar system delegate

extension Galaxy: SolarSystemDelegate {
     func solarSystemBecameBlackHole(_ star: Star, _ solarSystem: SolarSystem) {
          if let i = skyObjects.firstIndex(where: { $0.name == solarSystem.name }) {
            /*
             Mentor's comment:
             Good job, I think that keeping black hole in the same place where it's solar system were is a good idea. 👍
             */
               skyObjects[i] = star
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





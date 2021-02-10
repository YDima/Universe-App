//
//  Universe.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

class Universe: UniverseObject {
     
     var name: String
     var galaxies: [Galaxy] = []
     private var age: Int = 0
     private var timer: Timer?
     
     var blackHoleChangingPointMass: Double
     var blackHoleChangingPointRadius: Double
     
     weak var delegate: ChangesDelegate?
     
     init(name: String, blackHoleChangingPointMass: Double, blackHoleChangingPointRadius: Double) {
          self.name = name
          self.blackHoleChangingPointMass = blackHoleChangingPointMass
          self.blackHoleChangingPointRadius = blackHoleChangingPointRadius
          
          DispatchQueue.global(qos: .background).async { [weak self] in
               self?.timer = Timer.scheduledTimer(timeInterval: 1, target: self!, selector: #selector(self?.updateAge), userInfo: nil, repeats: true)
               RunLoop.current.run()
          }
          createNewGalaxy()
     }
}

//MARK: - Galaxies functionality

extension Universe: GalaxyDelegate {
     func createNewGalaxy() {
          let galaxy = Galaxy(name: "\(self.name)-G\(galaxies.count)", blackHoleChangingPointMass, blackHoleChangingPointRadius)
          galaxy.delegate = self
          galaxies.append(galaxy)
     }
     
     func galaxiesCollision() {
          var oldGalaxies = galaxies.filter({$0.age >= 180}).shuffled()
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

//MARK: - Update

extension Universe {
     @objc func updateAge() {
          self.age += 1
          
          if self.age%10 == 0 {
               createNewGalaxy()
          }
          if self.age%30 == 0 {
               galaxiesCollision()
          }
          
          galaxies.forEach {
               $0.updateAge()
          }
          self.delegate?.updateChanges()
     }
}


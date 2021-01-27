//
//  Star.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol StarDelegate {
     func starBecameBlackHole(_ star: Star)
}

class Star: SkyObject {
     internal var name: String
     internal var age = 0
     var mass = Double.random(in: 1...100)
     private var temperature = Double.random(in: 1...100)
     private var radius = Double.random(in: 1...100)
     private var luminosity = Double.random(in: 1...100)
     private var type = StarType.allCases.randomElement()
     private var starEvolution = StarEvolution.protostar
     
     var delegate: StarDelegate?
     
     private var starChangingPointMass: Double
     private var starChangingPointRadius: Double
     
     init(name: String,_ blackHoleChangingPointMass: Double,_ blackHoleChangingPointRadius: Double) {
          self.name = name
          self.starChangingPointMass = blackHoleChangingPointMass
          self.starChangingPointRadius = blackHoleChangingPointRadius
     }
}

//MARK: - Star evolution

extension Star {
     func updateAge() {
          self.age += 1
          
          if self.age%60 == 0 {
               nextEvolutionStage()
          }
          
     }
     
     func nextEvolutionStage() {
          switch starEvolution {
               case .protostar:
                    starEvolution = .mainSequence
               case .mainSequence:
                    if mass >= starChangingPointMass && radius >= starChangingPointRadius {
                         starEvolution = .blackHole
                         name = "Black Hole"
                         delegate?.starBecameBlackHole(self)
                    }
                    starEvolution = .dwarf
               default:
                    return
          }
     }
}




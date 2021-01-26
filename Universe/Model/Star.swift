//
//  Star.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol StarDelegate {
     func starBecameBlackHole()
}

class Star: SkyObject {
     internal var name: String
     internal var age = 0
     private var mass = Double.random(in: 1...100)
     private var temperature = Double.random(in: 1...100)
     private var radius = Double.random(in: 1...100)
     private var luminosity = Double.random(in: 1...100)
     private var type = StarType.allCases.randomElement()
     
     var delegate: StarDelegate?
     
     private var starChangingPointMass: Double?
     private var starChangingPointRadius: Double?
     
     init(name: String) {
          self.name = name
     }
}

//MARK: - Star evolution

extension Star: TimerDelegate {
     func updateAge() {
          self.age += 1
          
          
     }
}


//MARK: - Update star changing points data
extension Star: StarChangingPointDelegate {
     func updateStarData(_ blackHoleChangingPointMass: Double, _ blackHoleChangingPointRadius: Double) {
          self.starChangingPointMass = blackHoleChangingPointMass
          self.starChangingPointRadius = blackHoleChangingPointRadius
     }
     
}

//MARK: - Star types and evolution
private extension Star {
     enum StarEvolution: String {
          case protostar = "Newborn star"
          case mainSequence = "Star"
          case dwarf = "Dwarf"
          case blackHole = "Black hole"
     }
     
     enum StarType: String, CaseIterable {
          case yellow = "Yellow"
          case red = "Red"
          case blue = "Blue"
          case white = "White"
          case black = "Black"
     }
}


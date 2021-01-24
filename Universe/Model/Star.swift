//
//  Star.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol StarDelegate {
     
}

class Star {
     
     enum StarEvolution: String {
          
          // Star lifecycle:
          //                            -> Super Giant -> Supernova -> Black hole
          //                          /                             \
          // protostar -> mainSequence                                -> Neutron star
          //                          \
          //                            -> White dwarf -> Black dwarf
          // https://www.bbc.co.uk/bitesize/guides/zpxv97h/revision/1
          
          case protostar = "Newborn star"
          case mainSequence = "Star"
          case giant = "Giant"
          case supergiant = "Supergiant"
          case dwarf = "Dwarf"
          case supernova = "Supernova"
          case blackHole = "Black hole"
          case neutronStar = "Neutron"
     }
     
     enum StarType: String, CaseIterable {
          case yellow = "Yellow"
          case red = "Red"
          case blue = "Blue"
          case white = "White"
          case black = "Black"
     }
     
     private var mass: Double?
     private var temperature: Double?
     private var radius: Double?
     private var luminosity: Double?
     private var type = StarType.allCases.randomElement()
     
     private func initStarData() {
          self.mass = Double.random(in: 1...100)
          self.radius = Double.random(in: 1...100)
          self.temperature = Double.random(in: 1...100)
     }
     
}

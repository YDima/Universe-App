//
//  StarType.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import Foundation

//MARK: - Star types and evolution
extension Star {
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

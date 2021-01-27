//
//  GalaxyType.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import Foundation

//MARK: - Galaxy types

extension Galaxy {
     enum GalaxyType: String, CaseIterable {
          case spiral = "Spiral"
          case elliptical = "Elliptical"
          case lenticular = "Lenticular"
          case irregular = "Irregular"
     }
}

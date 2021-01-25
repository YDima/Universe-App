//
//  SolarSystem.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 23.1.21.
//

import Foundation

protocol SolarSystemDelegate {
     
}

class SolarSystem {
     private var name: String?
     private var age: Int = 0
     private var star: Star?
     private var planets: [Planet] = []
     
     init(name: String) {
          self.name = name
          star = Star(name: "Star")
     }
}

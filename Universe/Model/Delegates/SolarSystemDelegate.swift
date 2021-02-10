//
//  SolarSystemDelegate.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 10.2.21.
//

import Foundation

protocol SolarSystemDelegate: AnyObject {
    func solarSystemBecameBlackHole(_ star: Star, _ solarSystem: SolarSystem)
}

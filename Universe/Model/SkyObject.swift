//
//  SkyObject.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 25.1.21.
//

import Foundation

protocol SkyObject: UniverseObject {
     var name: String { get set }
     var age: Int { get set }
     var mass: Double { get }
     
     func updateAge()
}

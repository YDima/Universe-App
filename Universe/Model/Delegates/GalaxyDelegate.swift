//
//  GalaxyDelegate.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 10.2.21.
//

import Foundation

protocol GalaxyDelegate: AnyObject {
    func updateAfterGalaxiesCollision(galaxy: Galaxy)
}

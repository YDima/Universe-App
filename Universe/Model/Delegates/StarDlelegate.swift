//
//  StarDlelegate.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 10.2.21.
//

import Foundation

protocol StarDelegate: AnyObject {
    func starBecameBlackHole(_ star: Star)
}

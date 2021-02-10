//
//  StateMachineProtocol.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 27.1.21.
//

import UIKit

protocol StateMachineProtocol: AnyObject {
    func notifyStateMachine(source: UIViewController, _ event: Actions, _ universeObject: UniverseObject, coordinator: Coordinator)
}

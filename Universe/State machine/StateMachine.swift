//
//  StateMachine.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 27.1.21.
//

import Foundation

public class SimpleStateMachine<State, Event> where State: Hashable, Event: Hashable {
     private(set) var currentState: State
     private var states: [State : [Event : State]] = [:]
     
     public init(initialState: State) {
          currentState = initialState
     }
     
     public subscript(state: State) -> [Event : State]? {
          get {
               return states[state]
          }
          set(transitions) {
               states[state] = transitions
          }
     }
     
     public subscript(event: Event) -> State? {
          if let transitions = states[currentState] {
               if let nextState = transitions[event] {
                    return nextState
               }
          }
          return nil
     }
     
     public func transition(event: Event) -> State? {
          if let nextState = self[event] {
               currentState = nextState
               return nextState
          }
          return nil
     }
}

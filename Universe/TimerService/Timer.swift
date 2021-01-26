//
//  Timer.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 24.1.21.
//

import Foundation

class UniverseTimer {
     var delegate: TimerDelegate?
     var timer: Timer?

     func startTimer() {
          timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
               self.delegate?.updateAge()
          }
     }
     
}

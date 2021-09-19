//
//  Observable.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import Foundation

class Observable<Type> {
    
    private var subscribeAction :(Type?) -> () = { _ in }
    
    func subscribe(_ closure:@escaping (Type?) -> ()) {
        subscribeAction = closure
        
        if let value = value {
            self.subscribeAction(value)
        }
    }
    
    var value :Type? {
        didSet {
            subscribeAction(value)
        }
    }
    
    init(_ v :Type) {
        value = v
    }
    
}

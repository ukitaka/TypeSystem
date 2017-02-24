//
//  TypingContext.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

struct TypingContext {
    let assumptions: [TermVar]

    init() {
        self.assumptions = []
    }

    init(assumptions: [TermVar]) {
        self.assumptions = assumptions
    }
}

// MARK: - Substitution

extension Substitution {
    
}

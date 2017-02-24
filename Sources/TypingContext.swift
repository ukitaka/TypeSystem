//
//  TypingContext.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

struct TypingContext {
    let assumptions: [Term: Type]

    init() {
        self.assumptions = [:]
    }

    init(assumptions: [Term: Type]) {
        self.assumptions = assumptions
    }
}

// MARK: - Substitution

extension Substitution {
    
}

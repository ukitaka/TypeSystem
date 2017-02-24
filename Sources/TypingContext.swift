//
//  TypingContext.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

struct TypingContext {
    fileprivate let assumptions: Set<TermVar>

    init() {
        self.assumptions = []
    }

    init(assumptions: Set<TermVar>) {
        self.assumptions = assumptions
    }
}

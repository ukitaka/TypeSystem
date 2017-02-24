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

// MARK: - ExpressibleByDictionaryLiteral

extension TypingContext: ExpressibleByDictionaryLiteral {
    typealias Key = Term
    typealias Value = Type

    init(_ elements: (Key, Value)...) {
        var assumptions: [Key: Value] = [:]
        for (key, value) in elements {
            assumptions[key] = value
        }
        self.assumptions = assumptions
    }

    init(dictionaryLiteral elements: (Key, Value)...) {
        var assumptions: [Key: Value] = [:]
        for (key, value) in elements {
            assumptions[key] = value
        }
        self.assumptions = assumptions
    }
}

// MARK: - Equatable

extension TypingContext: Equatable {
    static func == (lhs: TypingContext, rhs: TypingContext) -> Bool {
        return lhs.assumptions == rhs.assumptions
    }
}

//
//  TypingContext.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

struct TypingContext<T: Term> {
    let assumptions: [T: Type]

    init() {
        self.assumptions = [:]
    }

    init(assumptions: [T: Type]) {
        self.assumptions = assumptions
    }

    func types(term: T) -> Type? {
        return assumptions[term]
    }
}

// MARK: - Substitutable

extension TypingContext: Substitutable {
    func substitute(_ s: Substitution) -> TypingContext {
        var assumptions: [T: Type] = [:]
        for (term, type) in self.assumptions {
            assumptions[term] = s.apply(type: type)
        }
        return TypingContext(assumptions: assumptions)
    }
}

// MARK: - ExpressibleByDictionaryLiteral

extension TypingContext: ExpressibleByDictionaryLiteral {
    typealias Key = T
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

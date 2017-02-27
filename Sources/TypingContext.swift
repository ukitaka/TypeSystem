//
//  TypingContext.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

struct TypingContext<T: Term> {
    fileprivate let _types: (T) -> Type?

    init() {
        self._types = { _ in return nil }
    }

    init(assumptions: [T: Type]) {
        self._types = { term in
            return assumptions[term]
        }
    }

    init(types: @escaping (T) -> Type?) {
        self._types = types
    }

    func types(term: T) -> Type? {
        return _types(term)
    }
}

// MARK: - Substitutable

extension TypingContext: Substitutable {
    func substitute(_ s: Substitution) -> TypingContext {
        return TypingContext { term in self._types(term).map(s.apply) }
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
        self._types = { term in
            return assumptions[term]
        }
    }

    init(dictionaryLiteral elements: (Key, Value)...) {
        var assumptions: [Key: Value] = [:]
        for (key, value) in elements {
            assumptions[key] = value
        }
        self._types = { term in
            return assumptions[term]
        }
    }
}

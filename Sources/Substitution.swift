//
//  Substitution.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

// MARK: - Substitution (σ)

struct Substitution {
    fileprivate let substitutions: [TypeVar: Type]

    init() {
        self.substitutions = [:]
    }

    init(substitutions: [TypeVar: Type]) {
        self.substitutions = substitutions
    }

    // MARK: - 

    var domain: [TypeVar] {
        return Array(substitutions.keys)
    }

    var range: [Type] {
        return Array(substitutions.values)
    }

    func contains(_ s: (TypeVar, Type)) -> Bool {
        return substitutions[s.0] == s.1
    }

    // MARK: - apply

    func lookup(typeVar: TypeVar) -> Type {
        assert(typeVar.isTypeVar)
        if let type = substitutions[typeVar] {
            return type
        } else {
            return typeVar
        }
    }

    func apply(type: Type) -> Type {
        switch type {
        case .typeVar:
            let lookedupType = lookup(typeVar: type)
            if (type == lookedupType) {
                return type
            } else {
                return apply(type: lookedupType)
            }

        case .arrow(let from, let to):
            return .arrow(apply(type: from), apply(type: to))

        case .type(let name):
            return .type(name)
        }
    }

    func apply(term: Term) -> Term {
        switch term {
        case .var(let name, let type):
            return .var(name, apply(type: type))
        case .lambda(let x, let e):
            return .lambda(x, apply(term: e))
        case .apply(let termL, let termR):
            return .apply(apply(term: termL), apply(term: termR))
        }
    }

    func apply(typingContext: TypingContext) -> TypingContext {
        return TypingContext(assumptions: typingContext.assumptions.map(apply))
    }

    // MARK: - unify

    func unifies(equation: Equation) -> Bool {
        return apply(type: equation.left) == apply(type: equation.right)
    }

    func unifies(constraintSet: ConstraintSet) -> Bool {
        return constraintSet.equations
            .map(unifies)
            .reduce(true) { $0.0 && $0.1 }
    }
}

// MARK: - 

extension Substitution: ExpressibleByDictionaryLiteral {
    typealias Key = TypeVar
    typealias Value = Type

    init(_ elements: (Key, Value)...) {
        var substitutions: [Key: Value] = [:]
        for (key, value) in elements {
            substitutions[key] = value
        }
        self.substitutions = substitutions
    }

    init(dictionaryLiteral elements: (Key, Value)...) {
        var substitutions: [Key: Value] = [:]
        for (key, value) in elements {
            substitutions[key] = value
        }
        self.substitutions = substitutions
    }
}

// MARK: - 

func • (σ: Substitution, γ: Substitution) -> Substitution {
    var substitutions: [TypeVar: Type] = [:]

    for (x, t) in γ.substitutions {
        substitutions[x] = σ.apply(type: t)
    }

    for (x, t) in σ.substitutions {
        if substitutions.keys.contains(x) {
            continue
        } else {
            substitutions[x] = t
        }
    }
    return Substitution(substitutions: substitutions)
}

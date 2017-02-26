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
    
    init(typeVar: TypeVar, type: Type) {
        self.substitutions = [typeVar: type]
    }

    init(substitutions: [TypeVar: Type]) {
        self.substitutions = substitutions
    }
}

// MARK: - Substitutable

protocol Substitutable {
    func substitute(_ substitution: Substitution) -> Self
}

// MARK: - utils

extension Substitution {

    var domain: [TypeVar] {
        return Array(substitutions.keys)
    }

    var range: [Type] {
        return Array(substitutions.values)
    }

    func contains(_ s: (TypeVar, Type)) -> Bool {
        return substitutions[s.0] == s.1
    }

    func extends(typeVar: TypeVar, type: Type) -> Substitution {
        var substitutions = self.substitutions
        substitutions[typeVar] = type
        return Substitution(substitutions: substitutions)
    }
}

// MARK: - apply

extension Substitution {
    func lookup(typeVar: TypeVar) -> Type {
        assert(typeVar.isTypeVar)
        if let type = substitutions[typeVar] {
            return type
        } else {
            return typeVar
        }
    }

    func apply(type: Type) -> Type {
        return type.substitute(self)
    }

    func apply(typingContext: TypingContext) -> TypingContext {
        var assumptions: [Term: Type] = [:]
        for (term, type) in typingContext.assumptions {
            assumptions[term] = apply(type: type)
        }
        return TypingContext(assumptions: assumptions)
    }

    func apply(equation: Equation) -> Equation {
        return equation.substitute(self)
    }

    func apply(constraintSet: ConstraintSet) -> ConstraintSet {
        return constraintSet.substitute(self)
    }
}

// MARK: - unify

extension Substitution {
    func unifies(equation: Equation) -> Bool {
        return apply(type: equation.left) == apply(type: equation.right)
    }

    func unifies(constraintSet: ConstraintSet) -> Bool {
        return constraintSet
            .map(unifies)
            .reduce(true) { $0.0 && $0.1 }
    }
}

// MARK: - ExpressibleByDictionaryLiteral

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

// MARK: - Equatable

extension Substitution: Equatable {
    static func == (lhs: Substitution, rhs: Substitution) -> Bool {
        return lhs.substitutions == rhs.substitutions
    }
}

// MARK: - CustomStringConvertible

extension Substitution: CustomStringConvertible {
    var description: String {
        return substitutions
            .map { (typeVar, type) -> String in
                typeVar.description + " ↦ " + type.description
            }
            .joined(separator: "\n")
    }
}

// MARK: - Composition

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

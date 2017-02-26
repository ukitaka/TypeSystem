//
//  𝔹ℕ.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/26.
//
//

import Foundation

indirect enum 𝔹ℕ: Term {
    case `var`(String, Type)
    case zero
    case succ(𝔹ℕ)
    case pred(𝔹ℕ)
    case `true`
    case `false`
    case isZero(𝔹ℕ)
    case ifThen(𝔹ℕ, 𝔹ℕ, 𝔹ℕ)
}

extension 𝔹ℕ {
    var type: Type {
        switch self {
        case .var(_, let t):
            return t
        case .zero, .succ, .pred:
            return 𝔹ℕ.Nat
        case .false, .true:
            return 𝔹ℕ.Bool
        case .isZero:
            return 𝔹ℕ.Bool
        case .ifThen(_, let then, _):
            return then.type
        }
    }
}

// MARK: - Generate constraint

func generateConstraint(term: 𝔹ℕ) -> ConstraintSet {
    switch term {
    case .var:
        return ConstraintSet()
    case .zero:
        return ConstraintSet()
    case .succ(let t):
        return (t.type ==== 𝔹ℕ.Nat) ∪ generateConstraint(term: t)
    case .pred(let t):
        return (t.type ==== 𝔹ℕ.Nat) ∪ generateConstraint(term: t)
    case .false, .true:
        return ConstraintSet()
    case .isZero(let t):
        return (t.type ==== 𝔹ℕ.Nat) ∪ generateConstraint(term: t)
    case .ifThen(let cond, let then, let els):
        return (then.type ==== els.type)
            ∪ (cond.type ==== 𝔹ℕ.Bool)
            ∪ generateConstraint(term: cond)
            ∪ generateConstraint(term: then)
            ∪ generateConstraint(term: els)
    }
}

// MARK: - Typing Context

extension 𝔹ℕ {
    static var Nat: Type {
        return .type("Nat")
    }

   static var Bool: Type {
        return .type("Bool")
    }

    static var Γ: TypingContext<𝔹ℕ> {
        return TypingContext<𝔹ℕ>(assumptions: [
            .zero: Nat,
            .true: Bool,
            .false: Bool,
        ])
    }
}

// MARK: - Equatable

extension 𝔹ℕ: Equatable {
    static func ==(lhs: 𝔹ℕ, rhs: 𝔹ℕ) -> Bool {
        switch (lhs, rhs) {
        case (.var(let name1), .var(let name2)):
            return name1 == name2
        case (.succ(let n1), .succ(let n2)):
            return n1 == n2
        case (.pred(let n1), .pred(let n2)):
            return n1 == n2
        case (.true, .true):
            return true
        case (.false, .false):
            return true
        case (.isZero(let z1), .isZero(let z2)):
            return z1 == z2
        case (.ifThen(let c1, let t1, let e1), .ifThen(let c2, let t2, let e2)):
            return c1 == c2 && t1 == t2 && e1 == e2
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible

extension 𝔹ℕ: CustomStringConvertible {
    var description: String {
        switch self {
        case .var(let name, _):
            return name
        case .zero:
            return "0"
        case .succ(let n):
            return "succ \(n)"
        case .pred(let n):
            return "pred \(n)"
        case .true:
            return "true"
        case .false:
            return "false"
        case .isZero(let z):
            return "isZero \(z)"
        case .ifThen(let c, let t, let e):
            return "if \(c) then \(t) else \(e)"
        }
    }
}

// MARK: - Hashable

extension 𝔹ℕ: Hashable {
    var hashValue: Int {
        return self.description.hashValue
    }
}

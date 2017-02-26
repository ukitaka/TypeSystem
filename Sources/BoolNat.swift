//
//  𝔹ℕ.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/26.
//
//

import Foundation

indirect enum 𝔹ℕ: Term {
    case `var`(String)
    case zero
    case succ(TypedTerm<𝔹ℕ>)
    case pred(TypedTerm<𝔹ℕ>)
    case `true`
    case `false`
    case isZero(TypedTerm<𝔹ℕ>)
    case ifThen(TypedTerm<𝔹ℕ>, TypedTerm<𝔹ℕ>, TypedTerm<𝔹ℕ>)
}

// MARK: Typing Context

extension 𝔹ℕ {
    var Nat: Type {
        return .type("Nat")
    }

    var Bool: Type {
        return .type("Bool")
    }

    var Γ: TypingContext<𝔹ℕ> {
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
        case .var(let name):
            return name
        case .zero:
            return "0"
        case .succ(let n):
            return "succ \(n.term)"
        case .pred(let n):
            return "pred \(n.term)"
        case .true:
            return "true"
        case .false:
            return "false"
        case .isZero(let z):
            return "isZero \(z.term)"
        case .ifThen(let c, let t, let e):
            return "if \(c.term) then \(t.term) else \(e.term)"
        }
    }
}

// MARK: - Hashable

extension 𝔹ℕ: Hashable {
    var hashValue: Int {
        return self.description.hashValue
    }
}

//
//  𝔹ℕ.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/26.
//
//

import Foundation

indirect enum 𝔹ℕ: Term {
    case `var`(Type)
    case zero
    case succ(𝔹ℕ)
    case pred(𝔹ℕ)
    case `true`
    case `false`
    case isZero(𝔹ℕ)
    case ifThen(𝔹ℕ, 𝔹ℕ, 𝔹ℕ)
}

// MARK: - Equatable

extension 𝔹ℕ: Equatable {
    static func ==(lhs: 𝔹ℕ, rhs: 𝔹ℕ) -> Bool {
        switch (lhs, rhs) {
        case (.var(let t1), .var(let t2)):
            return t1 == t2
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
        case .var(let type):
            return type.description
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

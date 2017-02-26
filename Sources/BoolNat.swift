//
//  𝔹ℕ.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/26.
//
//

import Foundation

indirect enum 𝔹ℕ: Term {
    case nat(Nat)
    case bool(Bool)
}

// MARK: - Equatable

extension 𝔹ℕ: Equatable {
    static func ==(lhs: 𝔹ℕ, rhs: 𝔹ℕ) -> Bool {
        switch (lhs, rhs) {
        case (.nat(let n1), .nat(let n2)):
            return n1 == n2
        case (.bool(let b1), .bool(let b2)):
            return b1 == b2
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible

extension 𝔹ℕ: CustomStringConvertible {
    var description: String {
        switch self {
        case .nat(let n):
            return n.description
        case .bool(let b):
            return b ? "true" : "false"
        }
    }
}

// MARK: - Hashable

extension 𝔹ℕ: Hashable {
    var hashValue: Int {
        return self.description.hashValue
    }
}

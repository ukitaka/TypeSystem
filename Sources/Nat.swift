//
//  Nat.swift
//  TypeSystem
//
//  Created by ST20841 on 2017/02/24.
//
//

import Foundation

indirect enum Nat {
    case zero
    case succ(Nat)
}

// MARK: -

extension Nat {
    var uIntValue: UInt {
        func f(_ n: Nat) -> UInt {
            switch n {
            case .zero: return 0
            case .succ(let nat): return f(nat) + 1
            }
        }
        return f(self)
    }
}

// MARK: - Equatable

extension Nat: Equatable {
    static func == (lhs: Nat, rhs: Nat) -> Bool {
        switch (lhs, rhs) {
        case (.zero, .zero):
            return true
        case (.succ(let n1), .succ(let n2)):
            return n1 == n2
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible

extension Nat: CustomStringConvertible {
    var description: String {
        return String(self.uIntValue)
    }
}

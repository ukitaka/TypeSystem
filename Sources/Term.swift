//
//  Term.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/24.
//
//

import Foundation

indirect enum Term {
    case `var`(String)
    case lambda(String, Term)
    case apply(Term, Term)
}

// MARK: -

extension Term {
    var isVar: Bool {
        switch self {
        case .var:
            return true
        default:
            return false
        }
    }

    var isLambda: Bool {
        switch self {
        case .lambda:
            return true
        default:
            return false
        }
    }

    var isApply: Bool {
        switch self {
        case .apply:
            return true
        default:
            return false
        }
    }
}

// MARK: - Equatable

extension Term: Equatable {
    static func ==(lhs: Term, rhs: Term) -> Bool {
        switch (lhs, rhs) {
        case (.var(let nameL), .var(let nameR)):
            return nameL == nameR
        case (.lambda(let nameL, let termL), .lambda(let nameR, let termR)):
            return nameL == nameR && termL == termR
        case (.apply(let termL1, let termL2), .apply(let termR1, let termR2)):
            return termL1 == termR1 && termL2 == termR2
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible

extension Term: CustomStringConvertible {
    var description: String {
        switch self {
        case .var(let name):
            return name
        case .lambda(let name, let term):
            return "λ" + name + ". " + term.description
        case .apply(let term1, let term2):
            return term1.description + " " + term2.description
        }
    }
}

// MARK: - Hashable

extension Term: Hashable {
    var hashValue: Int {
        return self.description.hashValue
    }
}
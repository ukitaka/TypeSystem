//
//  SimplyTypedLambdaCalculus.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/26.
//
//

import Foundation

indirect enum SimplyTypedLambdaCalculus: Term {
    case `var`(String)
    case lambda(String, SimplyTypedLambdaCalculus)
    case apply(SimplyTypedLambdaCalculus, SimplyTypedLambdaCalculus)
}

// MARK: -

extension SimplyTypedLambdaCalculus {
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

// MARK: - workaround

typealias TermVar = SimplyTypedLambdaCalculus
typealias Lambda = SimplyTypedLambdaCalculus
typealias Apply = SimplyTypedLambdaCalculus

// MARK: - Equatable

extension SimplyTypedLambdaCalculus: Equatable {
    static func ==(lhs: SimplyTypedLambdaCalculus, rhs: SimplyTypedLambdaCalculus) -> Bool {
        switch (lhs, rhs) {
        case (.var(let nameL), .var(let nameR)):
            return nameL == nameR
        case (.lambda(let nameL, let SimplyTypedLambdaCalculusL), .lambda(let nameR, let SimplyTypedLambdaCalculusR)):
            return nameL == nameR && SimplyTypedLambdaCalculusL == SimplyTypedLambdaCalculusR
        case (.apply(let termVarL1, let termVarL2), .apply(let termVarR1, let termVarR2)):
            return termVarL1 == termVarR1 && termVarL2 == termVarR2
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible

extension SimplyTypedLambdaCalculus: CustomStringConvertible {
    var description: String {
        switch self {
        case .var(let name):
            return name
        case .lambda(let name, let SimplyTypedLambdaCalculus):
            return "λ" + name + ". " + SimplyTypedLambdaCalculus.description
        case .apply(let termVar1, let termVar2):
            return termVar1.description + " " + termVar2.description
        }
    }
}

// MARK: - Hashable

extension SimplyTypedLambdaCalculus: Hashable {
    var hashValue: Int {
        return self.description.hashValue
    }
}

//
//  Type.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

indirect enum Type {
    case typeVar(String)
    case arrow(Type, Type)
    case type(String)
}

// MARK: - workaround

typealias TypeVar = Type
typealias Arrow = Type
typealias ConcreteType = Type

// MARK: - extensions

extension Type {
    var isTypeVar: Bool {
        switch self {
        case .typeVar:
            return true
        default:
            return false
        }
    }

    var isArrow: Bool {
        switch self {
        case .arrow:
            return true
        default:
            return false
        }
    }

    var isType: Bool {
        switch self {
        case .type:
            return true
        default:
            return false
        }
    }
}

extension Type {
    static func generateTypeVar(_ i: Int = AutoIncrement.next()) -> TypeVar {
        return .typeVar("a\(i)")

    }

    static var bool: ConcreteType {
        return .type("Bool")
    }

    static var nat: ConcreteType {
        return .type("Nat")
    }
}

extension Type: Equatable {
    static func ==(lhs: Type, rhs: Type) -> Bool {
        switch (lhs, rhs) {
        case (.typeVar(let l), .typeVar(let r)):
            return l == r
        case (.arrow(let l1, let l2), .arrow(let r1, let r2)):
            return l1 == r1 && l2 == r2
        case (.type(let name1), .type(let name2)):
            return name1 == name2
        default:
            return false
        }
    }
}

extension Type: CustomStringConvertible {
    var description: String {
        switch self {
        case .typeVar(let name):
            return "_\(name)"
        case .arrow(let t1, let t2):
            return "( " + t1.description + " > " + t2.description + ")"
        case .type(let name):
            return name
        }
    }
}

extension Type: Hashable {
    var hashValue: Int {
        return self.description.hashValue
    }
}

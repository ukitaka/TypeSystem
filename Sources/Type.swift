//
//  Type.swift
//  TypeSystem
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

// MARK: - Concrete types

extension Type {
    static var bool: ConcreteType {
        return .type("Bool")
    }

    static var nat: ConcreteType {
        return .type("Nat")
    }
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

    var typeVars: [TypeVar] {
        switch self {
        case .type:
            return []
        case .typeVar:
            return [self]
        case .arrow(let l, let r):
            return l.typeVars + r.typeVars
        }
    }
}

// MARK: - Substitutable

extension Type: Substitutable {
    func substitute(_ s: Substitution) -> Type {
        switch self {
        case .typeVar:
            let lookedupType = s.lookup(typeVar: self)
            if (self == lookedupType) {
                return self
            } else {
                return s.apply(type: lookedupType)
            }

        case .arrow(let from, let to):
            return .arrow(s.apply(type: from), s.apply(type: to))
            
        case .type(let name):
            return .type(name)
        }
    }
}


// MARK: - Equatable

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

// MARK: - CustomStringConvertible

extension Type: CustomStringConvertible {
    var description: String {
        switch self {
        case .typeVar(let name):
            return "_\(name)"
        case .arrow(let t1, let t2):
            return "(" + t1.description + " → " + t2.description + ")"
        case .type(let name):
            return name
        }
    }
}

// MARK: - Hashable

extension Type: Hashable {
    var hashValue: Int {
        return self.description.hashValue
    }
}

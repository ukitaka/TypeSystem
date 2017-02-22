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
    case typeConstructor(String, [Type])
}

extension Type {
    var isTyvar: Bool {
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

    var isTycon: Bool {
        switch self {
        case .typeConstructor:
            return true
        default:
            return false
        }
    }
}

extension Type: Equatable {
    static func ==(lhs: Type, rhs: Type) -> Bool {
        switch (lhs, rhs) {
        case (.typeVar(let l), .typeVar(let r)):
            return l == r
        case (.arrow(let l1, let l2), .arrow(let r1, let r2)):
            return l1 == r1 && l2 == r2
        case (.typeConstructor(let l1, let l2), .typeConstructor(let r1, let r2)):
            return l1 == r1 && l2 == r2
        default:
            return false
        }
    }
}

extension Type: CustomStringConvertible {
    var description: String {
        switch self {
        case .typeVar(let s):
            return s
        case .arrow(let t1, let t2):
            return "( " + t1.description + " > " + t2.description + ")"
        case .typeConstructor(let k, let ts):
            return k + (ts.isEmpty
                ? ""
                : "[" + ts.map { $0.description }.reduce("", +)) + "]"
        }
    }
}

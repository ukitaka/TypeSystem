//
//  Substitution.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

// MARK: - Substitution (σ)

/// Substitution (σ) is a finite mapping from type variable to type.
/// if σ = [ X ↦ T, Y ↦ S ]
/// then,
///  σ(X) = T
///  σ(Y) = S
///  σ(X → X) = σ(X) → σ(X) = T → T
///  σ(T) = T
protocol Substitution {
    func lookup(_ x: Type) -> Type
    func apply(_ type: Type) -> Type
}

extension Substitution {
    func apply(_ type: Type) -> Type {
        switch type {
        case .typeVar:
            let u = lookup(type)
            if (type == u) {
                return type
            } else {
                return apply(u)
            }
        case .arrow(let from, let to):
            return .arrow(apply(from), apply(to))
        }
    }
}

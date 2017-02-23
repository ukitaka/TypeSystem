//
//  Operators.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/23.
//
//

import Foundation

// MARK: - Substitution

infix operator ↦

func ↦ (lhs: TypeVar, rhs: ConcreteType) -> (TypeVar, ConcreteType) {
    return (lhs, rhs)
}

// MARK: - Arrow

infix operator →

func → (lhs: Type, rhs: Type) -> Arrow {
    return .arrow(lhs, rhs)
}

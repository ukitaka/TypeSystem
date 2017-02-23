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

// MARK: - Composition

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator • : CompositionPrecedence

// MARK: - Sets

infix operator ∈

func ∈ (lhs: (TypeVar, ConcreteType), rhs: Substitution) -> Bool {
    return rhs.contains(lhs)
}

infix operator ∋

func ∋ (lhs: Substitution, rhs: (TypeVar, ConcreteType)) -> Bool {
    return lhs.contains(rhs)
}

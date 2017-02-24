//
//  TypeSystem.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/24.
//
//

import Foundation

struct TypeSystem {
    let context: TypingContext
    let constraintSet: ConstraintSet

    func types(term: Term) -> Type {

        return .bool // FIXME
    }
}

//
//  TypeScheme.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

struct TypeScheme {
    let typeVars: [TypeVar]
    let expression: Type

    func instantiate() -> Type {
        let sub = typeVars.reduce(Substitution()) { (s, tv) in
            s.extend(typeVar: tv, type: .generateTypeVar())
        }
        return sub.apply(type: expression)
    }
}

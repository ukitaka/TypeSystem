//
//  Constraint.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/23.
//
//

import Foundation

struct Constraint {
    let left: Type
    let right: Type

    init(left: Type, right: Type) {
        self.left = left
        self.right = right
    }
}

struct Constraints {
    let constraints: [Constraint]

    init(constrant: Constraint) {
        self.constraints = [constrant]
    }

    init(constrants: [Constraint]) {
        self.constraints = constrants
    }
}

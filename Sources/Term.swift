//
//  Term.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/24.
//
//

import Foundation

protocol Term: Hashable {
 
}

typealias TypedTerm<T: Term> = (term: T, type: Type)

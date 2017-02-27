import XCTest
@testable import TypeSystem

class TypeSystemTests: XCTestCase {
    static var allTests : [(String, (TypeSystemTests) -> () throws -> Void)] {
        return [
            ("testApplySubstitutionToType",
             TypeSystemTests.testApplySubstitutionToType),
            ("testApplySubstitutionToTypingContext",
             TypeSystemTests.testApplySubstitutionToTypingContext),
            ("testComposeSubstitution",
             TypeSystemTests.testComposeSubstitution),
            ("testUnifyConstraintSet",
             TypeSystemTests.testUnifyConstraintSet)
        ]
    }

    // MRK: - Terms

    typealias STLC = SimplyTypedLambdaCalculus

    let x = STLC.var("x")
    let y = STLC.var("y")
    let z = STLC.var("z")
    let t = STLC.var("t")

    // MARK: - Types

    let X = Type.typeVar("X")
    let Y = Type.typeVar("Y")
    let Z = Type.typeVar("Z")

    let R = Type.type("R")
    let S = Type.type("S")
    let T = Type.type("T")
    let U = Type.type("U")
    
    // MARK: - Substitution Tests

    func testApplySubstitutionToType() {
        let σ: (Type) -> Type = Substitution(
            X ↦ T,
            Y ↦ S
        ).apply

        XCTAssertEqual(σ(X), T)
        XCTAssertEqual(σ(Y), S)
        XCTAssertEqual(σ(Z), Z)
        XCTAssertEqual(σ(T), T)
        XCTAssertEqual(σ(S), S)
        XCTAssertEqual(σ(X → X), σ(X) → σ(X))
        XCTAssertEqual(σ(X → X), T → T)
    }

    func testApplySubstitutionToTypingContext() {
        let σ: (TypingContext<STLC>) -> TypingContext<STLC> = Substitution(
            X ↦ T,
            Y ↦ S
        ).apply

        let Γ: TypingContext = [
            x: X,
            y: Y,
            z: Z
        ]

        let expectedΓ: TypingContext = [
            x: T,
            y: S,
            z: Z
        ]

        XCTAssertEqual(σ(Γ), expectedΓ)
    }

    func testComposeSubstitution() {
        let σ1 = Substitution(
            X ↦ T,
            Y ↦ S
        )

        let σ2 = Substitution(
            Y ↦ R,
            Z ↦ U
        )

        let σ: (Type) -> Type = (σ1 • σ2).apply
        
        XCTAssertEqual(σ(X), T)
        XCTAssertEqual(σ(Y), R)
        XCTAssertEqual(σ(Z), U)
        XCTAssertEqual(σ(T), T)
        XCTAssertEqual(σ(S), S)
    }

    // MARK: - TypingContext tests

    func testTyingContext() {
        let Γ: TypingContext = [
            t: T,
        ]

        XCTAssertEqual(Γ ⊢ t, T)
    }

    // MARK: - 

    func testUnifyConstraintSet() {
        let C: ConstraintSet = [
            X ==== (Y → Z),
            Y ==== T,
        ]

        let σ = unify(C)

        let expectedσ = Substitution(
            X ↦ (T → Z),
            Y ↦ T
        )

        XCTAssertEqual(σ, expectedσ)
    }

    // MARK : - Constraint generatoin

    func testGenerateConstraintSet() {
        let Γ = TypingContext<𝔹ℕ>()
        let term: 𝔹ℕ = .ifThen(.isZero(.var("x", X)), .var("z", Z), .var("y", Y))
        let C = generateConstraint(term: term, in: Γ)

        let σ = unify(C)

        let expectedσ = Substitution(
            X ↦ 𝔹ℕ.Nat,
            Z ↦ Y
        )

        XCTAssertEqual(σ, expectedσ)
    }

}

import XCTest
@testable import TypeSystem

class TypeSystemTests: XCTestCase {
    static var allTests : [(String, (TypeSystemTests) -> () throws -> Void)] {
        return [
            ("testSubstitution", TypeSystemTests.testSubstitution)
        ]
    }

    // MARK: - Types

    let X = Type.typeVar("X")
    let Y = Type.typeVar("Y")
    let Z = Type.typeVar("Z")

    let R = Type.type("R")
    let S = Type.type("S")
    let T = Type.type("T")
    let U = Type.type("U")
    
    // MARK: - Substitution Tests

    func testSubstitution() {
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
}

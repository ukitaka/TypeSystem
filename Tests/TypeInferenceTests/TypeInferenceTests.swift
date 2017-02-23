import XCTest
@testable import TypeInference

class TypeInferenceTests: XCTestCase {
    static var allTests : [(String, (TypeInferenceTests) -> () throws -> Void)] {
        return [
            ("testSubstitution", TypeInferenceTests.testSubstitution)
        ]
    }

    // MARK: - Substitution Tests

    func testSubstitution() {
        let X = Type.typeVar("X")
        let Y = Type.typeVar("Y")
        let Z = Type.typeVar("Z")
        let T = Type.type("T")
        let S = Type.type("S")

        let σ = Substitution(
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
}

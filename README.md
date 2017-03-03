## TypeSystem

Types And Programming Languages (型システム入門 プログラミング言語と型の理論)を読みながら作ったシンプルな型システムです。
主に第22章の「型再構築(型推論)」を実装したものです。 

Swiftで書かれていて、
訳語集の英語を名前の参考にしたり、本の中で使われている記号をoperator定義したりして、
本中の表現をなるべくそのままコードに落とし込めるようにしてあります。

```swift
// Substitution
let σ = Substitution(
    X ↦ T,
    Y ↦ S
).apply

XCTAssertEqual(σ(X), T)
XCTAssertEqual(σ(X → X), σ(X) → σ(X))
XCTAssertEqual(σ(X → X), T → T)

// TypingContext
let Γ: TypingContext = [
    t: T,
]

XCTAssertEqual(Γ ⊢ t, T)
```

## Grammar

```
t ::= x (変数)
      false
      true
      0
      succ t
      pred t
      isZero t
      if t1 then t2 else t3
```

Hindley-Milner型推論を実装していて、
`generateContraintSet` を使って制約を生成し、`unify`で単一化します。

```swift
let Γ = TypingContext<𝔹ℕ>()
let term: 𝔹ℕ = .ifThen(.isZero(.var("x", X)), .var("z", Z), .var("y", Y))

// Generate constraint set
let C = generateConstraintSet(term: term, in: Γ)

// Unify
let σ = unify(C)

let expectedσ = Substitution(
    X ↦ 𝔹ℕ.Nat,
    Z ↦ Y
)

XCTAssertEqual(σ, expectedσ)
```

## Generate `.xcodeproj`

```
$ swift package generate-xcodeproj
```


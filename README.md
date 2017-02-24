## [WIP] TypeSystem

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
    x: X,
    y: Y,
    z: Z
]

XCTAssertEqual(σ(Γ), expectedΓ)
```

## Generate `.xcodeproj`

```
$ swift package generate-xcodeproj
```


import XCTest
import Nimble

enum Error : ErrorType {
    case Laugh
    case Cry
}

enum EquatableError : ErrorType {
    case Parameterized(x: Int)
}

extension EquatableError : Equatable {
}

func ==(lhs: EquatableError, rhs: EquatableError) -> Bool {
    switch (lhs, rhs) {
    case (.Parameterized(let l), .Parameterized(let r)):
        return l == r
    }
}

enum CustomDebugStringConvertibleError : ErrorType {
    case A
    case B
}

extension CustomDebugStringConvertibleError : CustomDebugStringConvertible {
    var debugDescription : String {
        return "code=\(_code)"
    }
}

class ThrowErrorTest: XCTestCase {
    func testPositiveMatches() {
        expect { throw Error.Laugh }.to(throwError())
        expect { throw Error.Laugh }.to(throwError(Error.Laugh))
        expect { throw Error.Laugh }.to(throwError(errorType: Error.self))
        expect { throw EquatableError.Parameterized(x: 1) }.to(throwError(EquatableError.Parameterized(x: 1)))
    }

    func testPositiveMatchesWithClosures() {
        // Generic typed closure
        expect { throw EquatableError.Parameterized(x: 42) }.to(throwError { error in
            guard case EquatableError.Parameterized(let x) = error else { fail(); return }
            expect(x) >= 1
        })
        // Explicit typed closure
        expect { throw EquatableError.Parameterized(x: 42) }.to(throwError { (error: EquatableError) in
            guard case .Parameterized(let x) = error else { fail(); return }
            expect(x) >= 1
        })
        // Typed closure over errorType argument
        expect { throw EquatableError.Parameterized(x: 42) }.to(throwError(errorType: EquatableError.self) { error in
            guard case .Parameterized(let x) = error else { fail(); return }
            expect(x) >= 1
        })
        // Typed closure over error argument
        expect { throw Error.Laugh }.to(throwError(Error.Laugh) { (error: Error) in
            expect(error._domain).to(beginWith("Nim"))
        })
        // Typed closure over error argument
        expect { throw Error.Laugh }.to(throwError(Error.Laugh) { (error: Error) in
            expect(error._domain).toNot(beginWith("as"))
        })
    }

    func testNegativeMatches() {
        // Same case, different arguments
        failsWithErrorMessage("expected to throw error <Parameterized(2)>, got <Parameterized(1)>") {
            expect { throw EquatableError.Parameterized(x: 1) }.to(throwError(EquatableError.Parameterized(x: 2)))
        }
        // Same case, different arguments
        failsWithErrorMessage("expected to throw error <Parameterized(2)>, got <Parameterized(1)>") {
            expect { throw EquatableError.Parameterized(x: 1) }.to(throwError(EquatableError.Parameterized(x: 2)))
        }
        // Different case
        failsWithErrorMessage("expected to throw error <Cry>, got <Laugh>") {
            expect { throw Error.Laugh }.to(throwError(Error.Cry))
        }
        // Different case with closure
        failsWithErrorMessage("expected to throw error <Cry> that satisfies block, got <Laugh>") {
            expect { throw Error.Laugh }.to(throwError(Error.Cry) { _ in return })
        }
        // Different case, implementing CustomDebugStringConvertible
        failsWithErrorMessage("expected to throw error <code=1>, got <code=0>") {
            expect { throw CustomDebugStringConvertibleError.A }.to(throwError(CustomDebugStringConvertibleError.B))
        }
    }

    func testPositiveNegatedMatches() {
        // No error at all
        expect { return }.toNot(throwError())
        // Different case
        expect { throw Error.Laugh }.toNot(throwError(Error.Cry))
    }

    func testNegativeNegatedMatches() {
        // No error at all
        failsWithErrorMessage("expected to not throw any error, got <Laugh>") {
            expect { throw Error.Laugh }.toNot(throwError())
        }
        // Different error
        failsWithErrorMessage("expected to not throw error <Laugh>, got <Laugh>") {
            expect { throw Error.Laugh }.toNot(throwError(Error.Laugh))
        }
    }

    func testNegativeMatchesDoNotCallClosureWithoutError() {
        failsWithErrorMessage("expected to throw error that satisfies block, got no error") {
            expect { return }.to(throwError { error in
                fail()
            })
        }
        
        failsWithErrorMessage("expected to throw error <Laugh> that satisfies block, got no error") {
            expect { return }.to(throwError(Error.Laugh) { error in
                fail()
            })
        }
    }

    func testNegativeMatchesWithClosure() {
        let innerFailureMessage = "expected to equal <foo>, got <NimbleTests.Error>"
        let closure = { (error: Error) in
            expect(error._domain).to(equal("foo"))
        }

        failsWithErrorMessage([innerFailureMessage, "expected to throw error from type <Error> that satisfies block, got <Laugh>"]) {
            expect { throw Error.Laugh }.to(throwError(closure: closure))
        }

        failsWithErrorMessage([innerFailureMessage, "expected to throw error <Laugh> that satisfies block, got <Laugh>"]) {
            expect { throw Error.Laugh }.to(throwError(Error.Laugh, closure: closure))
        }
    }
}

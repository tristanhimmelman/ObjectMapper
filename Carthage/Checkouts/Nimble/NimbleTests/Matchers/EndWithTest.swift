import XCTest
import Nimble

class EndWithTest: XCTestCase {

    func testEndWithPositives() {
        expect([1, 2, 3]).to(endWith(3))
        expect([1, 2, 3]).toNot(endWith(2))

        expect("foobar").to(endWith("bar"))
        expect("foobar").toNot(endWith("oo"))

        expect(NSString(string: "foobar").description).to(endWith("bar"))
        expect(NSString(string: "foobar").description).toNot(endWith("oo"))

        expect(NSArray(array: ["a", "b"])).to(endWith("b"))
        expect(NSArray(array: ["a", "b"])).toNot(endWith("a"))
    }

    func testEndWithNegatives() {
        failsWithErrorMessageForNil("expected to end with <2>, got <nil>") {
            expect(nil as [Int]?).to(endWith(2))
        }
        failsWithErrorMessageForNil("expected to not end with <2>, got <nil>") {
            expect(nil as [Int]?).toNot(endWith(2))
        }

        failsWithErrorMessage("expected to end with <2>, got <[1, 2, 3]>") {
            expect([1, 2, 3]).to(endWith(2))
        }
        failsWithErrorMessage("expected to not end with <3>, got <[1, 2, 3]>") {
            expect([1, 2, 3]).toNot(endWith(3))
        }
        failsWithErrorMessage("expected to end with <atm>, got <batman>") {
            expect("batman").to(endWith("atm"))
        }
        failsWithErrorMessage("expected to not end with <man>, got <batman>") {
            expect("batman").toNot(endWith("man"))
        }
    }

}

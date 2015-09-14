import XCTest
import Nimble

class BeAnInstanceOfTest: XCTestCase {
    func testPositiveMatch() {
        expect(NSNull()).to(beAnInstanceOf(NSNull))
        expect(NSNumber(integer:1)).toNot(beAnInstanceOf(NSDate))
    }

    func testFailureMessages() {
        failsWithErrorMessageForNil("expected to not be an instance of NSNull, got <nil>") {
            expect(nil as NSNull?).toNot(beAnInstanceOf(NSNull))
        }
        failsWithErrorMessageForNil("expected to be an instance of NSString, got <nil>") {
            expect(nil as NSString?).to(beAnInstanceOf(NSString))
        }
        failsWithErrorMessage("expected to be an instance of NSString, got <__NSCFNumber instance>") {
            expect(NSNumber(integer:1)).to(beAnInstanceOf(NSString))
        }
        failsWithErrorMessage("expected to not be an instance of NSNumber, got <__NSCFNumber instance>") {
            expect(NSNumber(integer:1)).toNot(beAnInstanceOf(NSNumber))
        }
    }
    
    func testSwiftTypesFailureMessages() {
        enum TestEnum {
            case One, Two
        }

        failsWithErrorMessage("beAnInstanceOf only works on Objective-C types since the Swift compiler"
            + " will automatically type check Swift-only types. This expectation is redundant.") {
            expect(1).to(beAnInstanceOf(Int))
        }
        failsWithErrorMessage("beAnInstanceOf only works on Objective-C types since the Swift compiler"
            + " will automatically type check Swift-only types. This expectation is redundant.") {
            expect("test").to(beAnInstanceOf(String))
        }
        failsWithErrorMessage("beAnInstanceOf only works on Objective-C types since the Swift compiler"
            + " will automatically type check Swift-only types. This expectation is redundant.") {
            expect(TestEnum.One).to(beAnInstanceOf(TestEnum))
        }
    }
    
}

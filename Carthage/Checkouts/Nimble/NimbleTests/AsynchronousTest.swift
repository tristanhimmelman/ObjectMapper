import XCTest
import Nimble
import Swift

class AsyncTest: XCTestCase {
    let errorToThrow = NSError(domain: NSInternalInconsistencyException, code: 42, userInfo: nil)

    private func doThrowError() throws -> Int {
        throw errorToThrow
    }

    func testAsyncTestingViaEventuallyPositiveMatches() {
        var value = 0
        deferToMainQueue { value = 1 }
        expect { value }.toEventually(equal(1))

        deferToMainQueue { value = 0 }
        expect { value }.toEventuallyNot(equal(1))
    }

    func testAsyncTestingViaEventuallyNegativeMatches() {
        let value = 0
        failsWithErrorMessage("expected to eventually not equal <0>, got <0>") {
            expect { value }.toEventuallyNot(equal(0))
        }
        failsWithErrorMessage("expected to eventually equal <1>, got <0>") {
            expect { value }.toEventually(equal(1))
        }
        failsWithErrorMessage("expected to eventually equal <1>, got an unexpected error thrown: <\(errorToThrow)>") {
            expect { try self.doThrowError() }.toEventually(equal(1))
        }
        failsWithErrorMessage("expected to eventually not equal <0>, got an unexpected error thrown: <\(errorToThrow)>") {
            expect { try self.doThrowError() }.toEventuallyNot(equal(0))
        }
    }

    func testAsyncTestingViaWaitUntilPositiveMatches() {
        waitUntil { done in
            done()
        }
        waitUntil { done in
            deferToMainQueue {
                done()
            }
        }
    }

    func testAsyncTestingViaWaitUntilNegativeMatches() {
        failsWithErrorMessage("Waited more than 1.0 second") {
            waitUntil(timeout: 1) { done in return }
        }
        failsWithErrorMessage("Waited more than 0.01 seconds") {
            waitUntil(timeout: 0.01) { done in
                NSThread.sleepForTimeInterval(0.1)
                done()
            }
        }

        failsWithErrorMessage("expected to equal <2>, got <1>") {
            waitUntil { done in
                NSThread.sleepForTimeInterval(0.1)
                expect(1).to(equal(2))
                done()
            }
        }
        // "clear" runloop to ensure this test doesn't poison other tests
        NSRunLoop.mainRunLoop().runUntilDate(NSDate().dateByAddingTimeInterval(0.2))
    }

    func testWaitUntilDetectsStalledMainThreadActivity() {
        dispatch_async(dispatch_get_main_queue()) {
            NSThread.sleepForTimeInterval(2.0)
        }

        failsWithErrorMessage("Stall on main thread - too much enqueued on main run loop before waitUntil executes.") {
            waitUntil { done in
                done()
            }
        }

        // "clear" runloop to ensure this test doesn't poison other tests
        NSRunLoop.mainRunLoop().runUntilDate(NSDate().dateByAddingTimeInterval(2.0))
    }
}

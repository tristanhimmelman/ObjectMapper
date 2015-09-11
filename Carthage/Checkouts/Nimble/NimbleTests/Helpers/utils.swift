import Foundation
import Nimble
import XCTest

func failsWithErrorMessage(messages: [String], file: String = __FILE__, line: UInt = __LINE__, preferOriginalSourceLocation: Bool = false, closure: () throws -> Void) {
    var filePath = file
    var lineNumber = line

    let recorder = AssertionRecorder()
    withAssertionHandler(recorder, closure: closure)

    for msg in messages {
        var lastFailure: AssertionRecord?
        var foundFailureMessage = false

        for assertion in recorder.assertions {
            lastFailure = assertion
            if assertion.message.stringValue == msg {
                foundFailureMessage = true
                break
            }
        }

        if foundFailureMessage {
            continue
        }

        if preferOriginalSourceLocation {
            if let failure = lastFailure {
                filePath = failure.location.file
                lineNumber = failure.location.line
            }
        }

        if let lastFailure = lastFailure {
            let msg = "Got failure message: \"\(lastFailure.message.stringValue)\", but expected \"\(msg)\""
            XCTFail(msg, file: filePath, line: lineNumber)
        } else {
            XCTFail("expected failure message, but got none", file: filePath, line: lineNumber)
        }
    }
}

func failsWithErrorMessage(message: String, file: String = __FILE__, line: UInt = __LINE__, preferOriginalSourceLocation: Bool = false, closure: () -> Void) {
    return failsWithErrorMessage(
        [message],
        file: file,
        line: line,
        preferOriginalSourceLocation: preferOriginalSourceLocation,
        closure: closure
    )
}

func failsWithErrorMessageForNil(message: String, file: String = __FILE__, line: UInt = __LINE__, preferOriginalSourceLocation: Bool = false, closure: () -> Void) {
    failsWithErrorMessage("\(message) (use beNil() to match nils)", file: file, line: line, preferOriginalSourceLocation: preferOriginalSourceLocation, closure: closure)
}

func deferToMainQueue(action: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        NSThread.sleepForTimeInterval(0.01)
        action()
    }
}

public class NimbleHelper : NSObject {
    class func expectFailureMessage(message: NSString, block: () -> Void, file: String, line: UInt) {
        failsWithErrorMessage(message as String, file: file, line: line, preferOriginalSourceLocation: true, closure: block)
    }

    class func expectFailureMessages(messages: [NSString], block: () -> Void, file: String, line: UInt) {
        failsWithErrorMessage(messages as! [String], file: file, line: line, preferOriginalSourceLocation: true, closure: block)
    }

    class func expectFailureMessageForNil(message: NSString, block: () -> Void, file: String, line: UInt) {
        failsWithErrorMessageForNil(message as String, file: file, line: line, preferOriginalSourceLocation: true, closure: block)
    }
}

extension NSDate {
    convenience init(dateTimeString:String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let date = dateFormatter.dateFromString(dateTimeString)!
        self.init(timeInterval:0, sinceDate:date)
    }
}
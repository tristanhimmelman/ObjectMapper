import XCTest
@testable import ObjectMapperTests

XCTMain([
    testCase(NSDecimalNumberTransformTests.allTests),
    testCase(CustomTransformTests.allTests)
])

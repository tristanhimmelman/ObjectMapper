import XCTest
@testable import ObjectMapperTests

XCTMain([
    testCase(BasicTypesTestsFromJSON.allTests),
    testCase(BasicTypesTestsToJSON.allTests),
    testCase(NSDecimalNumberTransformTests.allTests),
    testCase(CustomTransformTests.allTests),
    testCase(ClassClusterTests.allTests)
])
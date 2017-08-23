import XCTest
@testable import ObjectMapperTests

XCTMain([
    testCase(BasicTypesTestsFromJSON.allTests),
    testCase(BasicTypesTestsToJSON.allTests),
    testCase(NSDecimalNumberTransformTests.allTests),
    testCase(CustomTransformTests.allTests),
    testCase(ClassClusterTests.allTests),
    testCase(DataTransformTests.allTests),
    testCase(DictionaryTransformTests.allTests),
    testCase(GenericObjectsTests.allTests),
    testCase(IgnoreNilTests.allTests),
    testCase(ImmutableObjectTests.allTests),
    testCase(MapContextTests.allTests),
    testCase(MappableExtensionsTests.allTests),
    testCase(MappableTypesWithTransformsTests.allTests),
])
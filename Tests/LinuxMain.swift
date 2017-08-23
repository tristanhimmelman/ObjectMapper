import XCTest
@testable import ObjectMapperTests

XCTMain([
    testCase(BasicTypesTestsFromJSON.allTests),
    testCase(BasicTypesTestsToJSON.allTests),
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
    testCase(NestedArrayTests.allTests),
    testCase(NestedKeysTests.allTests),
    testCase(NSDecimalNumberTransformTests.allTests),
    testCase(NullableKeysFromJSONTests.allTests),
    testCase(ObjectMapperTests.allTests),
    testCase(PerformanceTests.allTests),
    testCase(ToObjectTests.allTests),
    testCase(URLTransformTests.allTests)
])
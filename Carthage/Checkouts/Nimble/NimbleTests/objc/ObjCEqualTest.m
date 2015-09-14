#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCEqualTest : XCTestCase

@end

@implementation ObjCEqualTest

- (void)testPositiveMatches {
    expect(@1).to(equal(@1));
    expect(@1).toNot(equal(@2));
    expect(@1).notTo(equal(@2));
    expect(@"hello").to(equal(@"hello"));
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to equal <2.0000>, got <1.0000>", ^{
        expect(@1).to(equal(@2));
    });
    expectFailureMessage(@"expected to not equal <1.0000>, got <1.0000>", ^{
        expect(@1).toNot(equal(@1));
    });
}

- (void)testNilMatches {
    expectNilFailureMessage(@"expected to equal <nil>, got <nil>", ^{
        expect(nil).to(equal(nil));
    });
    expectNilFailureMessage(@"expected to not equal <nil>, got <nil>", ^{
        expect(nil).toNot(equal(nil));
    });
}

@end

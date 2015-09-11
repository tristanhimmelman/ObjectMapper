#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeGreaterThanTest : XCTestCase

@end

@implementation ObjCBeGreaterThanTest

- (void)testPositiveMatches {
    expect(@2).to(beGreaterThan(@1));
    expect(@2).toNot(beGreaterThan(@2));
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to be greater than <0.0000>, got <-1.0000>", ^{
        expect(@(-1)).to(beGreaterThan(@(0)));
    });
    expectFailureMessage(@"expected to not be greater than <1.0000>, got <0.0000>", ^{
        expect(@0).toNot(beGreaterThan(@(1)));
    });
}

- (void)testNilMatches {
    expectNilFailureMessage(@"expected to be greater than <-1.0000>, got <nil>", ^{
        expect(nil).to(beGreaterThan(@(-1)));
    });
    expectNilFailureMessage(@"expected to not be greater than <1.0000>, got <nil>", ^{
        expect(nil).toNot(beGreaterThan(@(1)));
    });
}

@end

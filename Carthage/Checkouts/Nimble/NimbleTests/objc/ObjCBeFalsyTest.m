#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeFalsyTest : XCTestCase

@end

@implementation ObjCBeFalsyTest

- (void)testPositiveMatches {
    expect(@NO).to(beFalsy());
    expect(@YES).toNot(beFalsy());
    expect(nil).to(beFalsy());
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to not be falsy, got <nil>", ^{
        expect(nil).toNot(beFalsy());
    });
    expectFailureMessage(@"expected to be falsy, got <1.0000>", ^{
        expect(@1).to(beFalsy());
    });
    expectFailureMessage(@"expected to be truthy, got <0.0000>", ^{
        expect(@NO).to(beTruthy());
    });
}

@end

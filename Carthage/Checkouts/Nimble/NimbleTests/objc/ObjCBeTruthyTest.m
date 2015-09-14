#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeTruthyTest : XCTestCase

@end

@implementation ObjCBeTruthyTest

- (void)testPositiveMatches {
    expect(@YES).to(beTruthy());
    expect(@NO).toNot(beTruthy());
    expect(nil).toNot(beTruthy());
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to be truthy, got <nil>", ^{
        expect(nil).to(beTruthy());
    });
    expectFailureMessage(@"expected to not be truthy, got <1.0000>", ^{
        expect(@1).toNot(beTruthy());
    });
    expectFailureMessage(@"expected to be truthy, got <0.0000>", ^{
        expect(@NO).to(beTruthy());
    });
}

@end

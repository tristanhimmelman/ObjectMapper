#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeTrueTest : XCTestCase

@end

@implementation ObjCBeTrueTest

- (void)testPositiveMatches {
    expect(@YES).to(beTrue());
    expect(@NO).toNot(beTrue());
    expect(nil).toNot(beTrue());
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to be true, got <0.0000>", ^{
        expect(@NO).to(beTrue());
    });
    expectFailureMessage(@"expected to be true, got <nil>", ^{
        expect(nil).to(beTrue());
    });
}

@end

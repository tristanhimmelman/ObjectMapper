#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeFalseTest : XCTestCase

@end

@implementation ObjCBeFalseTest

- (void)testPositiveMatches {
    expect(@NO).to(beFalse());
    expect(@YES).toNot(beFalse());
}

- (void)testNegativeMatches {
    expectNilFailureMessage(@"expected to be false, got <nil>", ^{
        expect(nil).to(beFalse());
    });
    expectNilFailureMessage(@"expected to not be false, got <nil>", ^{
        expect(nil).toNot(beFalse());
    });
}

@end

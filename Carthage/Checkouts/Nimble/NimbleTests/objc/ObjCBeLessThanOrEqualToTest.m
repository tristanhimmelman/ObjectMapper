#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeLessThanOrEqualToTest : XCTestCase

@end

@implementation ObjCBeLessThanOrEqualToTest

- (void)testPositiveMatches {
    expect(@2).to(beLessThanOrEqualTo(@2));
    expect(@2).toNot(beLessThanOrEqualTo(@1));
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to be less than or equal to <1.0000>, got <2.0000>", ^{
        expect(@2).to(beLessThanOrEqualTo(@1));
    });
    expectFailureMessage(@"expected to not be less than or equal to <1.0000>, got <1.0000>", ^{
        expect(@1).toNot(beLessThanOrEqualTo(@1));
    });
}

- (void)testNilMatches {
    expectNilFailureMessage(@"expected to be less than or equal to <1.0000>, got <nil>", ^{
        expect(nil).to(beLessThanOrEqualTo(@1));
    });
    expectNilFailureMessage(@"expected to not be less than or equal to <-1.0000>, got <nil>", ^{
        expect(nil).toNot(beLessThanOrEqualTo(@(-1)));
    });
}

@end

#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeLessThanTest : XCTestCase

@end

@implementation ObjCBeLessThanTest

- (void)testPositiveMatches {
    expect(@2).to(beLessThan(@3));
    expect(@2).toNot(beLessThan(@2));
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to be less than <0.0000>, got <-1.0000>", ^{
        expect(@(-1)).to(beLessThan(@0));
    });
    expectFailureMessage(@"expected to not be less than <1.0000>, got <0.0000>", ^{
        expect(@0).toNot(beLessThan(@1));
    });
}

- (void)testNilMatches {
    expectNilFailureMessage(@"expected to be less than <-1.0000>, got <nil>", ^{
        expect(nil).to(beLessThan(@(-1)));
    });
    expectNilFailureMessage(@"expected to not be less than <1.0000>, got <nil>", ^{
        expect(nil).toNot(beLessThan(@1));
    });
}

@end

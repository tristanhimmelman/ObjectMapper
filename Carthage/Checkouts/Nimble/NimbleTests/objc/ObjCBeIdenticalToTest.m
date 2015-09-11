#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCBeIdenticalToTest : XCTestCase

@end

@implementation ObjCBeIdenticalToTest

- (void)testPositiveMatches {
    NSNull *obj = [NSNull null];
    expect(obj).to(beIdenticalTo([NSNull null]));
    expect(@2).toNot(beIdenticalTo(@3));
}

- (void)testNegativeMatches {
    NSNull *obj = [NSNull null];
    expectFailureMessage(([NSString stringWithFormat:@"expected to be identical to <%p>, got <%p>", obj, @2]), ^{
        expect(@2).to(beIdenticalTo(obj));
    });
    expectFailureMessage(([NSString stringWithFormat:@"expected to not be identical to <%p>, got <%p>", obj, obj]), ^{
        expect(obj).toNot(beIdenticalTo(obj));
    });
}

- (void)testNilMatches {
    NSNull *obj = [NSNull null];
    expectNilFailureMessage(@"expected to be identical to nil, got nil", ^{
        expect(nil).to(beIdenticalTo(nil));
    });
    expectNilFailureMessage(([NSString stringWithFormat:@"expected to not be identical to <%p>, got nil", obj]), ^{
        expect(nil).toNot(beIdenticalTo(obj));
    });
}

@end

#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCAllPassTest : XCTestCase

@end

@implementation ObjCAllPassTest

- (void)testPositiveMatches {
    expect(@[@1, @2, @3,@4]).to(allPass(beLessThan(@5)));
    expect(@[@1, @2, @3,@4]).toNot(allPass(beGreaterThan(@5)));
    
    expect([NSSet setWithArray:@[@1, @2, @3,@4]]).to(allPass(beLessThan(@5)));
    expect([NSSet setWithArray:@[@1, @2, @3,@4]]).toNot(allPass(beGreaterThan(@5)));
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to all be less than <3.0000>, but failed first at element"
                         " <3.0000> in <[1.0000, 2.0000, 3.0000, 4.0000]>", ^{
                             expect(@[@1, @2, @3,@4]).to(allPass(beLessThan(@3)));
                         });
    expectFailureMessage(@"expected to not all be less than <5.0000>", ^{
        expect(@[@1, @2, @3,@4]).toNot(allPass(beLessThan(@5)));
    });
    expectFailureMessage(@"expected to not all be less than <5.0000>", ^{
        expect([NSSet setWithArray:@[@1, @2, @3,@4]]).toNot(allPass(beLessThan(@5)));
    });
    expectFailureMessage(@"allPass only works with NSFastEnumeration"
                         " (NSArray, NSSet, ...) of NSObjects, got <3.0000>", ^{
                             expect(@3).to(allPass(beLessThan(@5)));
                         });
    expectFailureMessage(@"allPass only works with NSFastEnumeration"
                         " (NSArray, NSSet, ...) of NSObjects, got <3.0000>", ^{
                             expect(@3).toNot(allPass(beLessThan(@5)));
                         });
}
@end

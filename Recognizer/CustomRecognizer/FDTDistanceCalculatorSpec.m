#import "Specs.h"

#import "FDTDistanceCalculator.h"

SpecBegin(FDTDistanceCalculator)

describe(@"FDTDistanceCalculator", ^{

    __block FDTDistanceCalculator *sut;

    beforeEach(^{
        sut = [[FDTDistanceCalculator alloc] init];
    });

    afterEach(^{
        sut = nil;
    });

    describe(@"correct distance calculation", ^{

        __block CGFloat result;

        action(^{
            result = [sut distanceFrom:@[@1, @2, @1] to:@[@2, @2, @2]];
        });

        it(@"should be correct distance", ^{
            expect(result).to.equal(0.6666666865348816);
        });
    });

    describe(@"another correct distance calculation", ^{

        __block CGFloat result;

        action(^{
            result = [sut distanceFrom:@[@1, @2, @1] to:@[@1, @2, @1]];
        });

        it(@"should be correct distance", ^{
            expect(result).to.equal(0);
        });
    });
});

SpecEnd
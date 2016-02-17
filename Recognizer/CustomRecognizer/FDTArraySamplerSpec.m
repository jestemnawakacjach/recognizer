#import "Specs.h"

#import "FDTArraySampler.h"

SpecBegin(FDTArraySampler)

describe(@"FDTArraySampler", ^{

    __block FDTArraySampler *sut;

    beforeEach(^{
        sut = [[FDTArraySampler alloc] init];
    });

    afterEach(^{
        sut = nil;
    });

    __block NSArray *samplerResult;

    action(^{
        samplerResult = [sut sample:@[@42, @43, @44, @45] toLenght:8];
    });


    it(@"should have correct count", ^{
        expect(samplerResult).to.haveCountOf(8);
    });

    it(@"should make correct samplification", ^{
        expect(samplerResult).to.equal(@[@42, @42, @42, @43, @43, @44, @44, @45]);
    });

});

SpecEnd
#import "Specs.h"

#import "FDTSimpleGestureProvider.h"
#import "FDTArraySampler.h"

SpecBegin(FDTSimpleGestureProvider)

describe(@"FDTSimpleGestureProvider", ^{

    __block FDTSimpleGestureProvider *sut;

    beforeEach(^{
        NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"C" withExtension:@"data"];
        sut = [[FDTSimpleGestureProvider alloc] initWithGestureFileURL:url];
    });

    afterEach(^{
        sut = nil;
    });

    it(@"should have sampler", ^{
        expect(sut.sampler).to.beKindOf([FDTArraySampler class]);
    });

    action(^{
        [sut testForGestureWithPoints:@[@1, @2, @3]];
    });

    describe(@"should call correct method", ^{

        __block id mockSampler;

        beforeEach(^{
            mockSampler = mock([FDTArraySampler class]);
            NSArray *samples = @[@1, @2, @3];
            NSArray *resampled = @[(@1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @2, @2, @2, @2, @2, @2, @2, @2, @2, @2, @3)];
            [given([mockSampler sample:samples toLenght:22]) willReturn:resampled];
            sut.sampler = mockSampler;

        });

        action(^{
            [verify(mockSampler) sample:@[@1, @2, @3] toLenght:22];
        });

        it(@"should be dummy test", ^{

        });


    });
});

SpecEnd
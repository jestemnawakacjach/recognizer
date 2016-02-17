#import "Specs.h"

#import "FDTSimpleGestureProvider.h"
#import "FDTArraySampler.h"
#import "FDTDistanceCalculator.h"

SpecBegin(FDTSimpleGestureProvider)

describe(@"FDTSimpleGestureProvider", ^{

    describe(@"success recognition", ^{

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

        it(@"should have distance calculator", ^{
            expect(sut.distanceCalculator).to.beKindOf([FDTDistanceCalculator class]);
        });

        __block BOOL result;

        action(^{
            result = [sut testForGestureWithPoints:@[@1, @2, @3]];
        });

        describe(@"should call correct method", ^{

            __block id mockSampler;
            __block id mockDistanceCalculator;
            __block NSArray *resampledPoints;

            beforeEach(^{
                mockSampler = mock([FDTArraySampler class]);
                mockDistanceCalculator = mock([FDTDistanceCalculator class]);

                [given([mockDistanceCalculator distanceFrom:anything() to:anything()]) willReturnFloat:0.2f];

                NSArray *samples = @[@1, @2, @3];
                resampledPoints = @[@1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @2, @2, @2, @2, @2, @2, @2, @2, @2, @2, @3];
                [given([mockSampler sample:samples toLenght:22]) willReturn:resampledPoints];

                sut.sampler = mockSampler;
                sut.distanceCalculator = mockDistanceCalculator;

            });

            action(^{
                [verify(mockSampler) sample:@[@1, @2, @3] toLenght:22];
                [verify(mockDistanceCalculator) distanceFrom:resampledPoints to:anything()];
            });

            it(@"should test finish with success", ^{
                expect(result).to.beTruthy();
            });
        });
    });

    describe(@"failure recognition", ^{
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

        it(@"should have distance calculator", ^{
            expect(sut.distanceCalculator).to.beKindOf([FDTDistanceCalculator class]);
        });

        __block BOOL result;

        action(^{
            result = [sut testForGestureWithPoints:@[@1, @2, @3]];
        });

        describe(@"should call correct method", ^{

            __block id mockSampler;
            __block id mockDistanceCalculator;
            __block NSArray *resampledPoints;

            beforeEach(^{
                mockSampler = mock([FDTArraySampler class]);
                mockDistanceCalculator = mock([FDTDistanceCalculator class]);

                [given([mockDistanceCalculator distanceFrom:anything() to:anything()]) willReturnFloat:0.8f];

                NSArray *samples = @[@1, @2, @3];
                resampledPoints = @[@1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @2, @2, @2, @2, @2, @2, @2, @2, @2, @2, @3];
                [given([mockSampler sample:samples toLenght:22]) willReturn:resampledPoints];

                sut.sampler = mockSampler;
                sut.distanceCalculator = mockDistanceCalculator;

            });

            action(^{
                [verify(mockSampler) sample:@[@1, @2, @3] toLenght:22];
                [verify(mockDistanceCalculator) distanceFrom:resampledPoints to:anything()];
            });

            it(@"should test finish with success", ^{
                expect(result).to.beFalsy();
            });
        });
    });

});

SpecEnd
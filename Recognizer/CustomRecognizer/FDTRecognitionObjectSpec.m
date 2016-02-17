#import "Specs.h"

#import "FDTRecognitionObject.h"

SpecBegin(FDTRecognitionObject)

describe(@"FDTRecognitionObject", ^{


    describe(@"object correctly initiated with name angles and preview data", ^{
        __block FDTRecognitionObject *sut;

        beforeEach(^{
            id mockedImage = mock([UIImage class]);
            sut = [[FDTRecognitionObject alloc] initWithName:@"Fixture name"
                                                      angles:@[@1, @0.5, @0.4]
                                                   urlString:@"Fixture url string"
                                            previewImageData:mockedImage];
        });

        afterEach(^{
            sut = nil;
        });

        describe(@"object correctly initiated with name angles and preview data", ^{

            it(@"should have name", ^{
                expect(sut.name).to.equal(@"Fixture name");
            });

            it(@"should have angles array with correct count", ^{
                expect(sut.angles).to.haveCountOf(3);
            });

            it(@"should have correct angles array", ^{
                expect(sut.angles).to.equal(@[@1, @0.5, @0.4]);
            });

            it(@"should url string", ^{
                expect(sut.urlString).to.equal(@"Fixture url string");
            });

            it(@"should have image", ^{
                expect(sut.previewImageData).to.beTruthy();
            });

        });
    });

    describe(@"object correctly initiated with file url", ^{
        __block FDTRecognitionObject *sut;

        beforeEach(^{
            NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"C" withExtension:@"data"];
            sut = [FDTRecognitionObject recognizerWithFileURL:url];
        });

        afterEach(^{
            sut = nil;
        });

        it(@"should have name", ^{
            expect(sut.name).to.equal(@"C");
        });

        it(@"should have angles array with correct count", ^{
            expect(sut.angles).to.haveCountOf(22);
        });

        it(@"should url string", ^{
            expect(sut.urlString).to.equal(@"http://c.com");
        });

        it(@"should have image", ^{
            expect(sut.previewImageData).to.beTruthy();
        });
    });
});

SpecEnd
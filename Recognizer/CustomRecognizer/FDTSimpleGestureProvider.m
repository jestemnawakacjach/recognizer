//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTSimpleGestureProvider.h"
#import "FDTRecognitionObject.h"
#import "FDTArraySampler.h"
#import "FDTDistanceCalculator.h"


@implementation FDTSimpleGestureProvider

- (instancetype)initWithGestureFileURL:(NSURL *)fileURL {
    self = [super init];

    if (self) {

        FDTRecognitionObject *recognitionObject = [FDTRecognitionObject recognizerWithFileURL:fileURL];
        _recognitionObject = recognitionObject;

        self.sampler = [[FDTArraySampler alloc] init];
        self.distanceCalculator = [[FDTDistanceCalculator alloc] init];
    }

    return self;
}

- (NSString *)gestureName {
    return self.recognitionObject.name;
}

- (NSString *)connectedURLString {
    return self.recognitionObject.urlString;
}

- (id)transformPoint:(CGPoint)point {
    return [NSValue valueWithCGPoint:point];
}

- (BOOL)testForGestureWithPoints:(NSArray *)points {

    NSArray *sampled = [self.sampler sample:points toLenght:self.recognitionObject.angles.count];
    CGFloat distance = [self.distanceCalculator distanceFrom:sampled to:self.recognitionObject.angles];
    return distance <= 0.7;
}

@end
//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTSimpleGestureProvider.h"
#import "FDTRecognitionObject.h"

@implementation FDTSimpleGestureProvider

- (instancetype)initWithGestureFilePath:(NSString *)filePath {

    self = [super init];

    if (self) {
        _fileName = [filePath lastPathComponent];
        filePath = [filePath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        FDTRecognitionObject *recognitionObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        _loadedPoints = recognitionObject.angles;
        _urlString = recognitionObject.urlString;
    }

    return self;
}

- (NSString *)gestureName {
    return self.fileName;
}
- (NSString *)connectedURLString {
    return self.urlString;
}
- (id)transformPoint:(CGPoint)point {
    return [NSValue valueWithCGPoint:point];
}

- (NSArray *)sample:(NSArray *)points {
    NSMutableArray *sample = [NSMutableArray new];

    NSUInteger loadedSampleCount = [self.loadedPoints count];
    NSUInteger c = [points count];

    for (NSUInteger i = 0; i < loadedSampleCount; i++) {
        NSUInteger index = MAX(0, (c - 1) * i / (loadedSampleCount - 1));
        [sample addObject:points[index]];
    }

    return sample;
}

- (BOOL)testForGestureWithPoints:(NSArray *)points {

    NSArray *sampled = [self sample:points];
    CGFloat distance = [self distance:sampled];
    return distance <= 0.7;
}

- (CGFloat)distanceBetweenAngles:(CGFloat)firstAngle second:(CGFloat)secondAngle {

    CGFloat phi = fabsf(secondAngle - firstAngle);
    phi = fmodf(phi, (float) (2 * M_PI));

    CGFloat distance = phi > M_PI ? (float) (2 * M_PI) - phi : phi;
    return distance;
}

- (CGFloat)distance:(NSArray *)points {

    CGFloat distance = 0.0;
    NSUInteger minCount = MIN(self.loadedPoints.count, points.count);

    for (NSUInteger i = 0; i < minCount; i++) {
        CGFloat aVal = [self.loadedPoints[i] floatValue];
        CGFloat bVal = [points[i] floatValue];
        distance += [self distanceBetweenAngles:aVal second:bVal];
    }

    distance = fabsf(distance / minCount);
    NSLog(@"%@ distance %f", self.gestureName, distance);
    return distance;
}

@end
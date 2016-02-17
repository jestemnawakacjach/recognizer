//
// Created by Karol Wawrzyniak on 17/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTDistanceCalculator.h"


@implementation FDTDistanceCalculator

- (CGFloat)distanceBetweenAngles:(CGFloat)firstAngle second:(CGFloat)secondAngle {

    CGFloat phi = fabsf(secondAngle - firstAngle);
    phi = fmodf(phi, (float) (2 * M_PI));

    CGFloat distance = phi > M_PI ? (float) (2 * M_PI) - phi : phi;
    return distance;
}

- (CGFloat)distanceFrom:(NSArray *)fromPoints to:(NSArray *)toPoints {

    CGFloat distance = 0.0;
    NSArray *angles = toPoints;
    NSUInteger minCount = MIN(angles.count, fromPoints.count);

    for (NSUInteger i = 0; i < minCount; i++) {
        CGFloat aVal = [angles[i] floatValue];
        CGFloat bVal = [fromPoints[i] floatValue];
        distance += [self distanceBetweenAngles:aVal second:bVal];
    }

    distance = fabsf(distance / minCount);
    return distance;
}
@end
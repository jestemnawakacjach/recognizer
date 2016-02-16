//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTRecognizer+Helper.h"


@implementation FDTRecognizer (Helper)
+ (NSArray *)transformCGPointsToAngles:(NSArray *)points {
    
    NSUInteger count = [points count] - 2;
    NSMutableArray *angleArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < count - 2; ++i) {

        CGPoint firstPoint = [points[i] CGPointValue];
        CGPoint secondPoint = [points[i + 1] CGPointValue];

        CGFloat xDiff = secondPoint.x - firstPoint.x;
        CGFloat yDiff = secondPoint.y - firstPoint.y;
        CGFloat angle = atan2f(yDiff, xDiff);
        [angleArray addObject:@(angle)];

    }
    return angleArray;
}

@end
//
// Created by Karol Wawrzyniak on 17/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FDTDistanceCalculator : NSObject
- (CGFloat)distanceFrom:(NSArray *)fromPoints to:(NSArray *)toPoints;
@end
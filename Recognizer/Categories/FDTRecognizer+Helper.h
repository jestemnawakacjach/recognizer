//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDTRecognizer.h"

@interface FDTRecognizer (Helper)
+(NSArray *)transformCGPointsToAngles:(NSArray *)points;
@end
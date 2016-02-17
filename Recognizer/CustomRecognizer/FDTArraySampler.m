//
// Created by Karol Wawrzyniak on 17/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTArraySampler.h"


@implementation FDTArraySampler

- (NSArray *)sample:(NSArray *)points toLenght:(NSUInteger)lenght {
    NSMutableArray *sample = [NSMutableArray new];

    NSUInteger loadedSampleCount = lenght;
    NSUInteger c = [points count];

    for (NSUInteger i = 0; i < loadedSampleCount; i++) {
        NSUInteger index = MAX(0, (c - 1) * i / (loadedSampleCount - 1));
        [sample addObject:points[index]];
    }

    return sample;
}

@end
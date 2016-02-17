//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDTRecognizer.h"

@class FDTRecognitionObject;
@class FDTArraySampler;
@class FDTDistanceCalculator;

@interface FDTSimpleGestureProvider : NSObject <FDTRecognizerProvider>

@property(nonatomic, readonly) FDTRecognitionObject *recognitionObject;

@property(nonatomic, strong) FDTArraySampler *sampler;

@property(nonatomic, strong) FDTDistanceCalculator *distanceCalculator;

- (instancetype)initWithGestureFileURL:(NSURL *)fileURL;

@end
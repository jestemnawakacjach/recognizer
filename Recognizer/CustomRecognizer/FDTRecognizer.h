//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FDTRecognizerProvider.h"
@class FDTRecognizer;

@interface FDTRecognizer : UIGestureRecognizer
@property (nonatomic, weak) id <FDTRecognizerProvider> provider;
@end
//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//
#import <UIKit/UIKit.h>

@class FDTRecognizer;


@protocol FDTRecognizerProvider <NSObject>

@property(nonatomic, readonly) NSString *gestureName;
@property(nonatomic, readonly) NSString *connectedURLString;

- (id)transformPoint:(CGPoint)point;

- (BOOL)testForGestureWithPoints:(NSArray *)points;

@end

@interface FDTRecognizer : UIGestureRecognizer
@property (nonatomic, weak) id <FDTRecognizerProvider> provider;
@end
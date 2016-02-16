//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTRecognizer.h"
#import "FDTRecognizer+Helper.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface FDTRecognizer ()
@property(nonatomic, strong) NSMutableArray *points;
@end

@implementation FDTRecognizer

- (void)reset {
    [super reset];
    self.points = nil;
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (touches.count > 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }

    self.points = [NSMutableArray array];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    id value = [self.provider transformPoint:point];
    [self.points addObject:value];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self.points addObject:[NSValue valueWithCGPoint:[touch locationInView:self.view]]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    if (self.points.count<2) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }

    BOOL detectionSuccess = [self.provider testForGestureWithPoints:[FDTRecognizer transformCGPointsToAngles:self.points]];

    if (detectionSuccess){
        self.state = UIGestureRecognizerStateRecognized;
    }
    else{
        self.state = UIGestureRecognizerStateFailed;
    }
}

@end
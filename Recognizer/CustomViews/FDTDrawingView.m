//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTDrawingView.h"


@implementation FDTDrawingView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    points = [[NSMutableArray alloc] init];
    [self addPointFrom:touches];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self addPointFrom:touches];
    [self setNeedsDisplay];
}

- (void)addPointFrom:(NSSet *)touches {
    CGPoint point = [[touches anyObject] locationInView:self];
    NSValue *value = [NSValue valueWithCGPoint:point];
    [points addObject:value];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self addPointFrom:touches];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
    CGContextFillRect(ctx, rect);
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
    for (NSValue *pointValue in points) {
        CGPoint pointInView = [pointValue CGPointValue];
        if (pointValue == [points objectAtIndex:0])
            CGContextMoveToPoint(ctx, pointInView.x, pointInView.y);
        else
            CGContextAddLineToPoint(ctx, pointInView.x, pointInView.y);
    }
    CGContextStrokePath(ctx);
}

- (UIImage *)captureImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
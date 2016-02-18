//
//  FDTRecognizerProvider.h
//  Recognizer
//
//  Created by Karol Wawrzyniak on 18/02/16.
//  Copyright © 2016 Karol Wawrzyniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FDTRecognizerProvider <NSObject>

@property(nonatomic, readonly) NSString *gestureName;
@property(nonatomic, readonly) NSString *connectedURLString;

- (id)transformPoint:(CGPoint)point;

- (BOOL)testForGestureWithPoints:(NSArray *)points;

@end

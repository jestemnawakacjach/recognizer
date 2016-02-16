//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDTRecognizer.h"

@interface FDTSimpleGestureProvider : NSObject <FDTRecognizerProvider>

@property(nonatomic, readonly) NSString *fileName;
@property(nonatomic, readonly) NSString *urlString;
@property(nonatomic, readonly) NSArray *loadedPoints;

- (instancetype)initWithGestureFilePath:(NSString *)name;
@end
//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Dirs)

+(NSString *)fullPathWithFileName:(NSString *)fileName;

- (NSArray *)savedGestures;

- (NSArray *)gesturesInBundle;
@end
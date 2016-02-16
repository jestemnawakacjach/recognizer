//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTRecognitionObject+Helpers.h"
#import "NSFileManager+Dirs.h"


@implementation FDTRecognitionObject (Helpers)
+ (NSArray *)fdt_allObjects {

    NSMutableArray *result = [NSMutableArray array];
    NSArray *bundleContents = [[NSFileManager defaultManager] gestureFileURLsInBundle];
    NSArray *savedGestures = [[NSFileManager defaultManager] savedGesturesURLs];

    NSMutableArray *dataURLs = [NSMutableArray array];

    [dataURLs addObjectsFromArray:bundleContents];
    [dataURLs addObjectsFromArray:savedGestures];

    for (NSURL *fileURL in dataURLs) {
        FDTRecognitionObject *recognitionObject = [FDTRecognitionObject recognizerWithFileURL:fileURL];
        [result addObject:recognitionObject];
    }

    return result;
}


@end
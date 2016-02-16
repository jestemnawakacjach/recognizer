//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "NSFileManager+Dirs.h"

@implementation NSFileManager (Dirs)

+ (NSString *)fullPathWithFileName:(NSString *)fileName {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentPath = ([documentPaths count] > 0) ? [documentPaths objectAtIndex:0] : nil;
    NSString *fullPath = [documentPath stringByAppendingPathComponent:fileName];
    return fullPath;
}

- (NSArray *)savedGestures {
    NSURL *gesturesURL = [[self URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
    NSArray *gestures = [self contentsOfDirectoryAtURL:gesturesURL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:nil];
    gestures = [gestures filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.pathExtension == %@", @"data"]];
    return gestures;
}

- (NSArray *)gesturesInBundle {
    NSArray *bundleContents = [[NSBundle mainBundle] URLsForResourcesWithExtension:@".data" subdirectory:nil];
    return bundleContents;
}

@end
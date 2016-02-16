//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTGesturesProviderImpl.h"
#import "NSFileManager+Dirs.h"

@interface FDTGesturesProviderImpl ()

@property(nonatomic, strong) NSMutableArray *datasource;

@end

@implementation FDTGesturesProviderImpl

@synthesize delegate;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self readGestures];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(gestureAdded:)
                                                     name:@"GestureAdded"
                                                   object:nil];
    }
    return self;
}

- (void)gestureAdded:(id)sender {
    [self readGestures];
    [self.delegate gestureListUpdated];
}

- (void)readGestures {
    self.datasource = [NSMutableArray new];
    NSArray *bundleContents = [[NSFileManager defaultManager] gesturesInBundle];
    NSArray *savedGestures = [[NSFileManager defaultManager] savedGestures];
    [self.datasource addObjectsFromArray:bundleContents];
    [self.datasource addObjectsFromArray:savedGestures];
}

- (NSString *)gestureNameAtIndex:(NSUInteger)index {
    NSURL *url = self.datasource[index];
    return [url lastPathComponent];
}

- (NSUInteger)gesturesCount {
    return [self.datasource count];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
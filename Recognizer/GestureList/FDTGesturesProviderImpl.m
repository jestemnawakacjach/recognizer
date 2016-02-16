//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTGesturesProviderImpl.h"
#import "NSFileManager+Dirs.h"
#import "FDTRecognitionObject.h"
#import "FDTRecognitionObject+Helpers.h"

@interface FDTGesturesProviderImpl ()

@property(nonatomic, strong) NSArray <FDTRecognitionObject *> *datasource;

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
    self.datasource = [FDTRecognitionObject fdt_allObjects];
}

- (void)decorateCell:(UITableViewCell *)cell forIndex:(NSInteger)index {

    cell.textLabel.text = [self.datasource[index] name];
    cell.imageView.image = [UIImage imageWithData:[self.datasource[index] previewImageData]];

}

- (FDTRecognitionObject *)recognitionObjectAtIndex:(NSInteger)index {
    return self.datasource[index];
}

- (NSUInteger)gesturesCount {
    return [self.datasource count];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
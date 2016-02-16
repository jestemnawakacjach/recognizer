//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDTRecognitionObject;

@protocol FDTGestureListDelegate

- (void)gestureListUpdated;

@end

@protocol FDTGestureListProvider

@property(nonatomic, weak) id <FDTGestureListDelegate> delegate;

- (NSUInteger)gesturesCount;

- (void)decorateCell:(UITableViewCell *)cell forIndex:(NSInteger)index;

- (FDTRecognitionObject *)recognitionObjectAtIndex:(NSInteger)index;

@end


@interface FDTSavedGestureListVC : UIViewController
@property(nonatomic, strong) id <FDTGestureListProvider> gesturesProvider;
@end
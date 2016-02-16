//
// Created by Karol Wawrzyniak on 15/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTDrawingView : UIView{
    NSMutableArray *points;
}
- (UIImage *)captureImage;
@end
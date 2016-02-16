//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "UIImage+PNGData.h"


@implementation UIImage (PNGData)

- (NSData *)imagePNGData {
    NSData *imageData = UIImagePNGRepresentation(self);
    return imageData;
}

@end
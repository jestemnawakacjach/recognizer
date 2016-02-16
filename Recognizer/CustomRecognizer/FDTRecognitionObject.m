//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTRecognitionObject.h"


@implementation FDTRecognitionObject

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.angles = [coder decodeObjectForKey:@"self.angles"];
        self.urlString = [coder decodeObjectForKey:@"self.urlString"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.angles forKey:@"self.angles"];
    [coder encodeObject:self.urlString forKey:@"self.urlString"];
}

- (instancetype)initWithAngles:(NSArray *)angles urlString:(NSString *)urlString {

    self = [super init];
    if (self) {
        self.angles = angles;
        self.urlString = urlString;
    }

    return self;
}

@end
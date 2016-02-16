//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTRecognitionObject.h"


@implementation FDTRecognitionObject

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"_name"];
        _angles = [coder decodeObjectForKey:@"_angles"];
        _urlString = [coder decodeObjectForKey:@"_urlString"];
        _previewImageData = [coder decodeObjectForKey:@"_previewImageData"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"_name"];
    [coder encodeObject:self.angles forKey:@"_angles"];
    [coder encodeObject:self.urlString forKey:@"_urlString"];
    [coder encodeObject:self.previewImageData forKey:@"_previewImageData"];
}

- (instancetype)initWithName:(NSString *)name angles:(NSArray *)angles urlString:(NSString *)urlString previewImageData:(NSData *)previewImageData {
    self = [super init];
    if (self) {
        _name = name;
        _angles = angles;
        _urlString = urlString;
        _previewImageData = previewImageData;
    }

    return self;
}

+ (instancetype)recognizerWithFileURL:(NSURL *)fileURL {
    NSString *filePath = [fileURL path];
    FDTRecognitionObject *recognitionObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return recognitionObject;
}

@end
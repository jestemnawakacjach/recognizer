//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FDTRecognitionObject : NSObject <NSCoding>

@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSArray *angles;
@property(nonatomic, readonly) NSString *urlString;
@property(nonatomic, readonly) NSData *previewImageData;

- (instancetype)initWithCoder:(NSCoder *)coder;

- (instancetype)initWithName:(NSString *)name angles:(NSArray *)angles urlString:(NSString *)urlString previewImageData:(NSData *)previewImageData;

+(instancetype)recognizerWithFileURL:(NSURL *)fileURL;

- (void)encodeWithCoder:(NSCoder *)coder;

@end
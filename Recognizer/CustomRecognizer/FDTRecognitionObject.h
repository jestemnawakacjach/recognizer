//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FDTRecognitionObject : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *angles;
@property (nonatomic, strong) NSString *urlString;

- (instancetype)initWithCoder:(NSCoder *)coder;

- (instancetype)initWithAngles:(NSArray *)angles urlString:(NSString *)urlString;


- (void)encodeWithCoder:(NSCoder *)coder;

@end
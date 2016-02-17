//
//  main.m
//  Recognizer
//
//  Created by Karol Wawrzyniak on 15/02/16.
//  Copyright © 2016 Karol Wawrzyniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    int returnValue;
    
    @autoreleasepool {
        BOOL inTests = NSClassFromString(@"XCTest") != nil;
        
        if (inTests) {
            //use a special empty delegate when we are inside the tests
            returnValue = UIApplicationMain(argc, argv, nil, @"FDTAppDelegate");
        }
        else {
            //use the normal delegate
            returnValue = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    
    return returnValue;

}

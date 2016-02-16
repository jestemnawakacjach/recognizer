//
//  FDTSaveGestureVC.m
//  Recognizer
//
//  Created by Karol Wawrzyniak on 15/02/16.
//  Copyright © 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTSaveGestureVC.h"
#import "NSFileManager+Dirs.h"
#import "FDTRecognizer.h"
#import "FDTRecognizer+Helper.h"
#import "FDTRecognitionObject.h"

@interface FDTSaveGestureVC ()
@property(nonatomic, strong) NSMutableArray *points;
@end

@implementation FDTSaveGestureVC

#pragma mark controller

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark

- (void)addTouchPoint:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    NSValue *valueToStore = [NSValue valueWithCGPoint:touchLocation];
    [self.points addObject:valueToStore];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.points = [[NSMutableArray alloc] init];
    [self addTouchPoint:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self addTouchPoint:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self showSaveAlert];

}

- (void)showSaveAlert {
    NSString *alertTitle = @"Podaj nazwę!";
    NSString *alertMessage = @"Podaj proszę nazwę wzoru, który narysowałeś";

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                             message:alertMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Nazwa";

    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"URL";
    }];


    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         [self handlerAction:alertController];
                                                     }];

    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)handlerAction:(UIAlertController *)alertController {
    UITextField *nameTextField = alertController.textFields.firstObject;
    UITextField *urlStringTextField = alertController.textFields.lastObject;

    NSArray *angles = [FDTRecognizer transformCGPointsToAngles:self.points];

    NSString *fullPath = [NSFileManager fullPathWithFileName:[NSString stringWithFormat:@"%@.data", nameTextField.text]];

    FDTRecognitionObject *recognitionObject = [[FDTRecognitionObject alloc] initWithAngles:angles urlString:urlStringTextField.text];

    [NSKeyedArchiver archiveRootObject:recognitionObject toFile:fullPath];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"GestureAdded" object:nil];
}


@end

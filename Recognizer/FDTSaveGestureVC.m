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
#import "FDTRecognitionObject.h"
#import "FDTDrawingView.h"
#import "UIImage+PNGData.h"

typedef FDTRecognitionObject *object;

@interface FDTSaveGestureVC ()
@property(weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property(nonatomic, strong) NSMutableArray *points;
@end

@implementation FDTSaveGestureVC

#pragma mark controller

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.recognitionObject) {
        self.previewImageView.image = [UIImage imageWithData:self.recognitionObject.previewImageData];
    } else {
        self.previewImageView.hidden = YES;
    }

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
    self.previewImageView.hidden = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self addTouchPoint:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (self.recognitionObject) {

    }

    [self showSaveAlert];

}

- (void)showSaveAlert {
    NSString *alertTitle = NSLocalizedString(@"save.gesture.alert.title", nil);

    NSString *alertMessage = NSLocalizedString(@"save.gesture.alert.message", nil);

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                             message:alertMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"save.gesture.alert.name.placeholder", nil);
        if (self.recognitionObject) {
            textField.text = self.recognitionObject.name;
        }


    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"save.gesture.alert.url.placeholder", nil);
        if (self.recognitionObject) {
            textField.text = self.recognitionObject.urlString;
        }
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
    NSData *imageData = [[(FDTDrawingView *) self.view captureImage] imagePNGData];

    object recognitionObject = [[FDTRecognitionObject alloc] initWithName:nameTextField.text
                                                                                      angles:angles
                                                                                   urlString:urlStringTextField.text
                                                                            previewImageData:imageData];

    [NSKeyedArchiver archiveRootObject:recognitionObject toFile:fullPath];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"GestureAdded" object:nil];
}


@end

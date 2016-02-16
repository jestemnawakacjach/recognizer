//
//  SecondViewController.m
//  Recognizer
//
//  Created by Karol Wawrzyniak on 15/02/16.
//  Copyright © 2016 Karol Wawrzyniak. All rights reserved.
//

#import "SecondViewController.h"
#import "FDTRecognizer+Helper.h"
#import "FDTSimpleGestureProvider.h"
#import "NSFileManager+Dirs.h"

@interface SecondViewController () <UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSMutableArray *points;
@property(nonatomic, strong) NSMutableArray *providers;
@property(weak, nonatomic) IBOutlet UILabel *recognizedLabel;

@end

@implementation SecondViewController


- (void)addRecognizerWithFileURL:(NSURL *)fileURL {

    FDTSimpleGestureProvider *simpleProvider = [[FDTSimpleGestureProvider alloc] initWithGestureFileURL:fileURL];
    FDTRecognizer *recognizer = [[FDTRecognizer alloc] initWithTarget:self action:@selector(detected:)];
    recognizer.provider = simpleProvider;
    recognizer.delegate = self;

    [self.providers addObject:simpleProvider];
    [self.view addGestureRecognizer:recognizer];
}

- (void)addGestures {

    NSArray *existingRecognizers = [self.view.gestureRecognizers filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"class == %@", [FDTRecognizer class]]];

    for (UIGestureRecognizer *gestureRecognizer in existingRecognizers) {
        [self.view removeGestureRecognizer:gestureRecognizer];
    }

    self.providers = [[NSMutableArray alloc] init];

    NSMutableArray *recognizersURLs = [[[NSFileManager defaultManager] gestureFileURLsInBundle] mutableCopy];
    NSArray *recognizersURLsINCache = [[NSFileManager defaultManager] savedGesturesURLs];
    [recognizersURLs addObjectsFromArray:recognizersURLsINCache];

    for (NSURL *fileURL in recognizersURLs) {
        [self addRecognizerWithFileURL:fileURL];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.recognizedLabel.text = @"Recognized:";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGestures];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addGestures) name:@"GestureAdded" object:nil];
}

- (void)detected:(FDTRecognizer *)sender {
    NSLog(@"detected %@", [sender.provider gestureName]);
    self.recognizedLabel.text = [NSString stringWithFormat:@"Recognized: %@\n redirecting: %@",
                                                           [sender.provider gestureName], [sender.provider connectedURLString]];

    dispatch_after(1, dispatch_get_main_queue(), ^() {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[sender.provider connectedURLString]]];
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

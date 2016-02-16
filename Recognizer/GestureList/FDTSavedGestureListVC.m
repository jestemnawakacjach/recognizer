//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTSavedGestureListVC.h"
#import "FDTGesturesProviderImpl.h"
#import "FDTRecognitionObject.h"
#import "FDTSaveGestureVC.h"

@interface FDTSavedGestureListVC () <UITableViewDataSource, UITableViewDelegate, FDTGestureListDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation FDTSavedGestureListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.gesturesProvider = [[FDTGesturesProviderImpl alloc] init];
    self.gesturesProvider.delegate = self;

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addCustomGesture:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)addCustomGesture:(id)sender {
    UIViewController *saveGesture = [self.storyboard instantiateViewControllerWithIdentifier:@"SaveGestureVC"];
    [self.navigationController pushViewController:saveGesture animated:YES];
}

#pragma mark FDTGestureListDelegate

- (void)gestureListUpdated {
    [self.tableview reloadData];
}

#pragma mark tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gesturesProvider gesturesCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    [self.gesturesProvider decorateCell:cell forIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FDTSaveGestureVC *savedGestureListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SaveGestureVC"];
    savedGestureListVC.recognitionObject = [self.gesturesProvider recognitionObjectAtIndex:indexPath.row];
    [self.navigationController pushViewController:savedGestureListVC animated:YES];
}


@end
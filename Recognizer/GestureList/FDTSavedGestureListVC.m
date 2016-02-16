//
// Created by Karol Wawrzyniak on 16/02/16.
// Copyright (c) 2016 Karol Wawrzyniak. All rights reserved.
//

#import "FDTSavedGestureListVC.h"
#import "FDTGesturesProviderImpl.h"

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
    cell.textLabel.text = [self.gesturesProvider gestureNameAtIndex:indexPath.row];
    return cell;
}


@end
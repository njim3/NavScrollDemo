//
//  DetailVC.m
//  NavScrollDemo
//
//  Created by njim3 on 2018/10/16.
//  Copyright © 2018 njim3. All rights reserved.
//

#import "DetailVC.h"

#define ROW_COUNT       15

@interface DetailVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* datasourceMutArr;

@end

@implementation DetailVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self constructDatasource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavColorWithAlpha: 1.0f];
}

#pragma mark - Logical Process
- (void)constructDatasource {
    for (int i = 0; i < ROW_COUNT; ++i) {
        [self.datasourceMutArr addObject: @((self.passCode + i) * 10)];
    }
}

#pragma mark - UITableView datasource & delegate methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.datasourceMutArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT_DETAILVC_TABLE;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: CELLIDENTIFIER_DETAILVC];
    
    cell.textLabel.text = [NSString stringWithFormat:
                           @"Now the number is %@.",
                           self.datasourceMutArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
}

#pragma mark - Variables getter
- (NSMutableArray*)datasourceMutArr {
    if (!_datasourceMutArr) {
        _datasourceMutArr = [NSMutableArray array];
    }
    
    return _datasourceMutArr;
}


@end

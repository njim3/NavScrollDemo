//
//  HomeVC.m
//  NavScrollDemo
//
//  Created by njim3 on 2018/10/15.
//  Copyright © 2018 njim3. All rights reserved.
//

#import "HomeVC.h"
#import "DetailVC.h"

#define ROW_COUNT       10

@interface HomeVC () <UIScrollViewDelegate, UITableViewDelegate,
UITableViewDataSource> {
    CGFloat _navAlpha;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mainSV;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainSVHeight;

@property (nonatomic, strong) NSMutableArray* dsMutArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *topBannerIV;

@property (nonatomic, strong) MJRefreshNormalHeader* mjHeader;

@end

@implementation HomeVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self constructData];
    [self layoutViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavColorWithAlpha: _navAlpha];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.mainSVHeight.constant = SCREEN_HEIGHT + 1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.destinationViewController isKindOfClass: [DetailVC class]]) {
        DetailVC* detailVC = (DetailVC*)segue.destinationViewController;
        
        detailVC.passCode = [sender intValue];
        
        _navAlpha = [self calculateAlpha];
    }
}

#pragma mark - View Layout
- (void)layoutViews {
    self.mainSV.mj_header = self.mjHeader;
    
    self.mainSV.contentInsetAdjustmentBehavior =
    UIScrollViewContentInsetAdjustmentNever;
    
    [self setTableViewLayout];
}

- (void)setTableViewLayout {
    self.tableView.rowHeight = HEIGHT_HOMEVC_TABLE;
}

#pragma mark - View Action
- (void)adaptView {
    self.mainSVHeight.constant = self.tableView.frame.origin.y +
    self.dsMutArr.count * HEIGHT_HOMEVC_TABLE;
}

- (void)getRefreshData {
    dispatch_queue_t refreshQueue = dispatch_queue_create("refreshqueue", NULL);
    
    dispatch_async(refreshQueue, ^{
        
        sleep(3);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainSV.mj_header endRefreshing];
        });
    });
}

#pragma mark - Logical Process
- (void)constructData {
    _navAlpha = 0.0f;
    
    [self.dsMutArr removeAllObjects];
    
    for (int i = 0; i < ROW_COUNT; ++i) {
        [self.dsMutArr addObject: @(i + 1)];
    }
}

- (CGFloat)calculateAlpha {
    CGFloat offsetY = self.mainSV.contentOffset.y;
    
    if (offsetY < 0.0)
        offsetY = 0.0f;
    
    CGFloat bottomGradualY = self.topBannerIV.frame.size.height / 2 - NAVBAR_HEIGHT;
    CGFloat alpha = 1.0f;
    
    if (offsetY < bottomGradualY) {
        alpha = 1.0f - (bottomGradualY - offsetY) / bottomGradualY;
        
        if (alpha > 0.5) {
            self.title = @"首页";
        } else {
            self.title = @"";
        }
    }
    
    return alpha;
}

#pragma mark - UITableView delegate & datasource methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dsMutArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                             CELLIDENTIFIER_HOMEVC];
    
    cell.textLabel.text = [NSString stringWithFormat: @"Here is the number %@.",
                           self.dsMutArr[indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    [self performSegueWithIdentifier: SEGUE_HOME2DETAIL
                              sender: self.dsMutArr[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==
        ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row) {
        [self adaptView];
    }
}


#pragma mark - UIScrollView delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setNavColorWithAlpha: [self calculateAlpha]];
}


#pragma mark - Variables getter
- (NSMutableArray*)dsMutArr {
    if (!_dsMutArr) {
        _dsMutArr = [NSMutableArray array];
    }
    
    return _dsMutArr;
}

- (MJRefreshNormalHeader*)mjHeader {
    if (!_mjHeader) {
        _mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self getRefreshData];
        }];
        
        _mjHeader.lastUpdatedTimeLabel.hidden = YES;
        
        [_mjHeader setTitle: @"下拉刷新"
                   forState: MJRefreshStateIdle];
        [_mjHeader setTitle: @"释放以刷新"
                   forState: MJRefreshStatePulling];
        [_mjHeader setTitle: @"刷新中..."
                   forState: MJRefreshStateRefreshing];
    }
    
    return _mjHeader;
}

@end

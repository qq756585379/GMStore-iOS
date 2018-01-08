//
//  DCFootprintGoodsViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define FootprintScreenW (SCREEN_WIDTH * 0.4)

#import "DCFootprintGoodsViewController.h"
#import "GMRecommendItem.h"
#import "DCFootprintCell.h"
#import "UIViewController+XWTransition.h"

@interface DCFootprintGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
/* 整个足迹浏览View */
@property (strong , nonatomic)UIView *footprintView;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 足迹数据 */
@property (strong , nonatomic)NSMutableArray<GMRecommendItem *> *footprintItem;
@end

@implementation DCFootprintGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpFootprintAlterView];
    
    [self setUpInit];

    [self setUpHeadTitle];
    
    [self setUpData];
}

- (void)setUpInit
{
    self.view.backgroundColor = YJBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _footprintView = [[UIView alloc] init];
    _footprintView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_footprintView];
    [_footprintView addSubview:_tableView];

    _footprintView.frame = CGRectMake(0, 0, FootprintScreenW, SCREEN_HEIGHT);
}

#pragma mark - 足迹数据
- (void)setUpData
{
    _footprintItem = [GMRecommendItem mj_objectArrayWithFilename:@"FootprintGoods.plist"];
}

#pragma mark - 我的足迹
- (void)setUpHeadTitle
{
    UILabel *myFootLabel = [[UILabel alloc] init];
    myFootLabel.text = @"我的足迹";
    myFootLabel.textAlignment = NSTextAlignmentCenter;
    myFootLabel.font = PFR15Font;
    
    [_footprintView addSubview:myFootLabel];
    myFootLabel.frame  = CGRectMake(0, 20, FootprintScreenW, 44);
    
    _tableView.frame = CGRectMake(0, myFootLabel.bottom, FootprintScreenW, SCREEN_HEIGHT - myFootLabel.bottom);
}

#pragma mark - 弹出弹框
- (void)setUpFootprintAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionLeft;
    WEAK_SELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf selfViewBack];
    } edgeSpacing:80];
}

#pragma mark - 退出当前View
- (void)selfViewBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _footprintItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCFootprintCell *cell = [tableView dequeueReusableCellWithIdentifier:[DCFootprintCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.footprintItem = _footprintItem[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FootprintScreenW + 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了足迹的第%zd条数据",indexPath.row);
}

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[DCFootprintCell class] forCellReuseIdentifier:[DCFootprintCell cellReuseIdentifier]];
    }
    return _tableView;
}

@end

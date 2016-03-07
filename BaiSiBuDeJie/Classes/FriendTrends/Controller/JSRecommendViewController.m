//
//  JSRecommendViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/23.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "JSRecommendCategoryCell.h"
#import <MJExtension.h>
#import "JSRecommendCategory.h"
#import "JSRecommendUserCell.h"
#import "JSRecommendUser.h"
#import "MJRefresh.h"


#define JSSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface JSRecommendViewController () <UITableViewDataSource,UITableViewDelegate>

/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray *categories;

/**
 *  右边的用户数据
 */
//@property (nonatomic, strong) NSArray *users;

/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/**
 *  右边的用户表格
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


/**
 *  请求参数
 */
@property (nonatomic, strong) NSMutableDictionary *params;


@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation JSRecommendViewController

static NSString * const JSCategoryID = @"category";
static NSString * const JSUserID = @"user";

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self setUpTableView];
    
    // 添加刷新控件
    [self setUpRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}

#pragma mark - 加载左侧的类别数据
- (void)loadCategories {
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        self.categories = [JSRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选择首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入刷新状态
        [self.userTableView.header beginRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        JSLog(@"%@", error);
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];

}


- (void)setUpTableView {
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:JSCategoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:JSUserID];
    
    // 设置 inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 设置标题
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = JSGlobalBackGroundColor;
}


#pragma mark - 添加刷新控件
- (void)setUpRefresh {
    
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.footer.hidden = YES;
}

#pragma mark - 加载最新用户数据
- (void)loadNewUsers {

    JSRecommendCategory *rc = JSSelectedCategory;
    
    // 设置当前页码为1
    rc.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = rc.id;
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        // 字典数组 -> 模型数组
        NSArray *users = [JSRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 由于 百思不得姐 自身api设计 加载最新数据需要删除原先旧数据
        // 清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        
        // 处理网速慢带来的问题，params 是第一次发送的参数
        // 处理最后一次请求
        if (self.params != params) {
            return;
        }
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.header endRefreshing];
        
        [self checkFooterState];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return;
        }
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.header endRefreshing];
    }];
    

}

#pragma mark - 加载更多用户数据
- (void)loadMoreUsers {
    JSRecommendCategory *category = JSSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.id;
    params[@"page"] = @(++category.currentPage);
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 字典数组 -> 模型数组
        NSArray *users = [JSRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        if (self.params != params) {
            return;
        }
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return;
        }
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.footer endRefreshing];

    }];
}


/**
 *  时刻检测footer的状态
 */
- (void)checkFooterState {
    JSRecommendCategory *rc = JSSelectedCategory;
    
    self.userTableView.footer.hidden = (rc.users.count == 0);
    
    if (rc.users.count == rc.total) {
        // 全部加载完毕
        [self.userTableView.footer noticeNoMoreData];
    } else {
        // 让底部控件结束刷新
        [self.userTableView.footer endRefreshing];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 左边的类别表格
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    
    // 检测footer的状态
    [self checkFooterState];
    
    // 右边的用户表格
    return [JSSelectedCategory users].count;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categoryTableView) {
        // 左边的类别表格
        JSRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:JSCategoryID];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    } else {
        // 右边的用户表格
        JSRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:JSUserID];
//        JSRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
//        cell.user = c.users[indexPath.row];
        cell.user = [JSSelectedCategory users][indexPath.row];

        
        // 左边被选中的类别模型
        
        return cell;
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 结束刷新
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    
    JSRecommendCategory *c = self.categories[indexPath.row];
    
    //
    [self.userTableView.footer noticeNoMoreData];
    
    
    // 判断右边曾经是否有数据
    if (c.users.count) {
        // 右边有数据
        [self.userTableView reloadData];
        
    } else {
        // 马上刷新表格，显示当前category的用户数据，不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
        
    }

}


#pragma mark - 控制器的销毁
- (void)dealloc {
    // 停止所有请求操作
    [self.manager.operationQueue cancelAllOperations];
}






@end

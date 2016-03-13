//
//  JSTopicViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/9/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopicViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "JSTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "JSTopicCell.h"

@interface JSTopicViewController ()

/**
 *  帖子数据
 */
@property (nonatomic, strong) NSMutableArray *topics;

/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger page;

/**
 *  当加载下一个参数时需要这个参数
 */
@property (nonatomic, copy) NSString *maxtime;

/**
 *  上一次的请求参数
 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation JSTopicViewController


- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setUpTableView];
    
    // 添加刷新控件
    [self setUpRefresh];
    
    
}

static NSString * const JSTopicCellID = @"topic";

- (void)setUpTableView {
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = JSTitlesViewH + JSTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条内边距, 解决 tableview 滚动条被挡
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSTopicCell class]) bundle:nil] forCellReuseIdentifier:JSTopicCellID];
}

#pragma mark - 添加刷新控件
- (void)setUpRefresh {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

#pragma mark - 加载新的数据帖子
- (void)loadNewTopics {
    // 结束上拉刷新
    [self.tableView.footer endEditing:YES];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        // 细节处理 多个请求以最后一个请求为准
        if (self.params != params) {
            return;
        }
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        self.topics = [JSTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
        // 清空页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return;
        }
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - 加载更多帖子数据
- (void)loadMoreTopics {
    // 结束下拉刷新
    [self.tableView.header endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if (self.params != params) {
            return;
        }
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        NSArray *newTopics = [JSTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
        
        // 设置页码
        self.page = page;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return;
        }
        // 结束刷新
        [self.tableView.header endRefreshing];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:JSTopicCellID];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}


@end

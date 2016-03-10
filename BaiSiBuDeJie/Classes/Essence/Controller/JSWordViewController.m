//
//  JSWordViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/9/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSWordViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "JSTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface JSWordViewController ()

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

@implementation JSWordViewController

- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加刷新控件
    [self setUpRefresh];
    
    
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
    params[@"type"] = @"29";
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
    
    self.page++;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = @(self.page);
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
        
        //        [responseObject writeToFile:@"/Users/leo/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return;
        }
        // 结束刷新
        [self.tableView.header endRefreshing];
        // 恢复页码
        self.page--;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    JSTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}


@end

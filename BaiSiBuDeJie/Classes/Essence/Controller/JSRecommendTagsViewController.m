//
//  JSRecommendTagsViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/3/2.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSRecommendTagsViewController.h"
#import "AFNetworking.h"
#import <SVProgressHUD.h>
#import "JSRecommendTag.h"
#import "MJExtension.h"
#import "JSRecommendTagCell.h"

@interface JSRecommendTagsViewController ()

/**
 *  标签数组
 */
@property (nonatomic, strong) NSArray *tags;

@end

static NSString * const JSTagId = @"tag";

@implementation JSRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    // 加载标签数据
    [self loadTags];
    
    
}

- (void)loadTags {
    // 发送请求
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.tags = [JSRecommendTag objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
}


- (void)setupTableView {
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:JSTagId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = JSGlobalBackGroundColor;
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:JSTagId];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end

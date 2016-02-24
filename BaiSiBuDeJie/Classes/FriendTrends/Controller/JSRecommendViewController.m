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

@interface JSRecommendViewController () <UITableViewDataSource,UITabBarDelegate>

/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray *categories;

/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation JSRecommendViewController

static NSString * const JSCategoryID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:JSCategoryID];
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = JSGlobalBackGroundColor;
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        JSLog(@"%@", responseObject);
        
        self.categories = [JSRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选择首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

        // 隐藏指示器
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JSRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:JSCategoryID];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

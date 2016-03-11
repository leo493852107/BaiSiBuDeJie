//
//  JSAllViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/9/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSAllViewController.h"

@interface JSAllViewController ()

@end

@implementation JSAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setUpTableView];
    
}

- (void)setUpTableView {
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = JSTitlesViewH + JSTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条内边距, 解决 tableview 滚动条被挡
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [self class], indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JSLog(@"%@", NSStringFromUIEdgeInsets(tableView.contentInset));
    JSLog(@"%@", NSStringFromCGRect(tableView.frame));
}


@end

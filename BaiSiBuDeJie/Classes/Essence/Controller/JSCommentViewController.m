//
//  JSCommentViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 5/22/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSCommentViewController.h"
#import "JSTopicCell.h"
#import "JSTopic.h"

@interface JSCommentViewController () <UITableViewDelegate,UITableViewDataSource>

/** 工具条间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JSCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    
    [self setUpHeader];
    
}


- (void)setUpHeader {
    
    // 创建 header
    UIView *header = [[UIView alloc] init];
    
    // 添加 cell
    JSTopicCell *cell = [JSTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(JSScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    // header 高度
    header.height = self.topic.cellHeight + JSTopicCellMargin + 50;
    
    // 设置 header
    self.tableView.tableHeaderView = header;
    
}

- (void)setBasic {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = JSGlobalBackGroundColor;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 键盘 显示/隐藏 完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSpace.constant = JSScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - <UITableViewDelegate>
// 拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"评论";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd", indexPath.section, indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

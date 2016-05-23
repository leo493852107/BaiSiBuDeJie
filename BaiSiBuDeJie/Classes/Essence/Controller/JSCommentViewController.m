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
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "JSComment.h"
#import <MJExtension.h>
#import "JSCommentHeaderView.h"
#import "JSCommentCell.h"

static NSString * const JSCommentId = @"comment";

@interface JSCommentViewController () <UITableViewDelegate,UITableViewDataSource>

/** 工具条间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的 top_cmt */
@property (nonatomic, strong) JSComment *saved_top_cmt;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation JSCommentViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    
    [self setUpHeader];
    
    [self setUpRefresh];
}

- (void)setUpRefresh {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.footer.hidden =  YES;
}

- (void)loadMoreComments {
    // 结束之前的所有请求 cancel 会调用failure方法
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码处理
    NSInteger page = self.page++;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    JSComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [_manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 最新评论
        NSArray *comments = [JSComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments addObjectsFromArray:comments];
        
        // 页码处理
        self.page = page;
        
        // 刷新表格数据
        [self.tableView reloadData];
        
        //        [responseObject writeToFile:@"/Users/leo/Desktop/tiezi.plist" atomically:YES];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            // 全部加载完毕
            //            [self.tableView.footer noticeNoMoreData];
            self.tableView.footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}

- (void)loadNewComments {
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [_manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        self.hotComments = [JSComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [JSComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 页码，以前的数据都不要了
        self.page = 1;
        
        // 刷新数据
        [self.tableView reloadData];
        
//        [responseObject writeToFile:@"/Users/leo/Desktop/tiezi.plist" atomically:YES];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            // 全部加载完毕
//            [self.tableView.footer noticeNoMoreData];
            self.tableView.footer.hidden = YES;
        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}

- (void)setUpHeader {
    
    // 创建 header
    UIView *header = [[UIView alloc] init];
    
    // 清空 top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
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
    
    // cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 背景色
    self.tableView.backgroundColor = JSGlobalBackGroundColor;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JSCommentCell class]) bundle:nil] forCellReuseIdentifier:JSCommentId];
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, JSTopicCellMargin, 0);
    
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
    
    // 恢复帖子的 top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    // 取消所有任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
    
}

/** 返回第section组的所有评论数据 */
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (JSComment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>
// 拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) { // 最热评论 + 最新评论 2组
        return 2;
    }
    if (latestCount) { // 有最新评论 1组
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    // 隐藏尾部控件
    tableView.footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第 0 组
    return latestCount;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    // 创建头部
//    UIView *header = [[UIView alloc] init];
//    header.backgroundColor = JSGlobalBackGroundColor;
//    
//    // 创建label
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = JSRGBColor(67, 67, 67);
//    label.width = 200;
//    label.x = JSTopicCellMargin;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [header addSubview:label];
//    
//    // 设置文字
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//    return header;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    static NSString *ID = @"header";
//    // 先从缓存池中找 header
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    
//    UILabel *label = nil;
//    
//    if (header == nil) {
//        // 缓存池中没有，自己创建
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor = JSGlobalBackGroundColor;
//        // 创建label
//        label = [[UILabel alloc] init];
//        label.textColor = JSRGBColor(67, 67, 67);
//        label.width = 200;
//        label.x = JSTopicCellMargin;
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        label.tag = JSHeaderLabelTag;
//        [header.contentView addSubview:label];
//    } else {
//        // 从缓存池中取出
//        label = (UILabel *)[header viewWithTag:JSHeaderLabelTag];
//        
//    }
//    
//    // 设置label数据
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//
//    
//    return header;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 先从缓存池中找 header
    JSCommentHeaderView *header = [JSCommentHeaderView headerViewWithTableView:tableView];
    
    // 设置label数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:JSCommentId];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

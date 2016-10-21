//
//  XDTimeLineTableViewController.m
//  MsmChat
//
//  Created by 高晓东 on 16/8/22.
//  Copyright © 2016年 mengxx. All rights reserved.
//
#import "XDTimeLineTableViewController.h"
#import "XDCircleOfFriendsCell.h"
#import "XDCircleOfFriendsCellModel.h"
#import "GloabalDefines.h"
#import "UIView+SDAutoLayout.h"///View自适应
#import "UITableView+SDAutoTableViewCellHeight.h"///高度自适应
#import "LEETheme.h"
#import "XDImagePicker.h"
//重用标示
#define kTimeLineTableViewCellId @"XDCircleCell"
static CGFloat textFieldH = 40;
/***朋友圈***/

static int RightButton = 0;//记录拍照按钮点击次数
@interface XDTimeLineTableViewController () <XDCircleOfFriendsDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;//文本框
@property (nonatomic, assign) BOOL isReplayingComment; ///提交
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath; ///当前编辑索引路径
@property (nonatomic, copy) NSString *commentToUser; ///注释用户

@end

@implementation XDTimeLineTableViewController
{
    CGFloat _lastScrollViewOffsetY;///记录滚动后的偏移量Y坐标
    CGFloat _totalKeybordHeight;///记录键盘高度
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载组件
    [self LoadViewComponent];
    
}
/*** 重写tableView位置 ***/
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
}
/*** 加载组件 ***/
-(void)LoadViewComponent {
    //自动调节滚动型插图
    self.automaticallyAdjustsScrollViewInsets = NO;
    //边线扩展布局
    self.edgesForExtendedLayout = UIRectEdgeTop;
    //将信息放入数组
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    //添加右上按钮
    [self AddTheTopRightButton];
    //创建键盘
    [self setupTextField];
    //加载通知中心
    [self AcceptNoticeNews];
    //注册cell
    [self.tableView registerClass:[XDCircleOfFriendsCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
}
/*** 接受通知消息 ***/
-(void)AcceptNoticeNews{
    //键盘高度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //tableView滑动通知
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"123" object:nil];
}
-(void)notice:(id)sender{
    //打开tableView滑动
    self.tableView.scrollEnabled = YES;
}
/*** 释放 ***/
- (void)dealloc
{
    //    [_refreshHeader removeFromSuperview];
    //    [_refreshFooter removeFromSuperview];
    [self.tableView removeFromSuperview];
    //释放掉textView
    [_textField removeFromSuperview];
    //释放去掉通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*** 视图出现时 ***/
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
/*** 视图消失时 ***/
- (void)viewWillDisappear:(BOOL)animated
{
    [_textField resignFirstResponder];
    //消失时打开标签控制器
    self.tabBarController.tabBar.hidden = NO;
}
/*** 添加右上按钮 ***/
-(void) AddTheTopRightButton {
    //添加右上照片按钮
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Camera"] style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItemAction:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
/*** 右栏目按钮点击事件 ***/
-(void) rightBarButtonItemAction:(UIBarButtonItem *)sender{
    //tableview停止滑动
    //判断按钮点击次数
    if (RightButton == 0) {
        self.tableView.scrollEnabled = NO;
        [[XDImagePicker shareInstance] showWithController:self finished:^(UIImage *image) {
            //        NSLog(@"获得图片进行相应的操作... image=%@",image);
        } animated:YES];
        RightButton += 1;
        
    } else {
        self.tableView.scrollEnabled = YES;
        RightButton -= 1;
        
    }

}
/*** 创建键盘textField ***/
- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    //输入评论时.背景框色彩
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    _textField.lee_theme
    .LeeAddBackgroundColor(DAY , [UIColor whiteColor])
    .LeeAddBackgroundColor(NIGHT , [UIColor blackColor])
    .LeeAddTextColor(DAY , [UIColor blackColor])
    .LeeAddTextColor(NIGHT , [UIColor grayColor])
    .LeeAddCustomConfig(DAY , ^(UITextField *item){
        
        item.keyboardAppearance = UIKeyboardAppearanceDefault;
        if ([item isFirstResponder]) {
            [item resignFirstResponder];
            [item becomeFirstResponder];
        }
    }).LeeAddCustomConfig(NIGHT , ^(UITextField *item){
        
        item.keyboardAppearance = UIKeyboardAppearanceDark;
        if ([item isFirstResponder]) {
            [item resignFirstResponder];
            [item becomeFirstResponder];
        }
    });
    
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width_sd, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];

    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

/*** 模拟模型 ***/
- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"程蝶衣",
                            @"段小楼",
                            @"菊仙",
                            @"袁四爷",
                            @"作者李碧华"];
    
    NSArray *textArray = @[@"说的是一辈子！差一年，一个月，一天，一个时辰，都不算一辈子！",
                           @"人，得自个儿成全自个儿。要想人前显贵，必得人后受罪！",
                           @"帝王将相，才人佳子的故事，诸位听得不少。那些情情义义，恩恩爱爱，卿卿我我，都瑰丽莫名。根本不是人间颜色。人间，只是抹去了脂粉的脸。",
                           @"印象最深刻的经典台词：1.不行！说的是一辈子！差一年，一个月，一天，一个时辰，都不算一辈子!2.楚霸王都跪下来求饶了，京戏能不亡吗3.一笑万古春，一啼万古愁，此景非你莫有，此貌非你莫属。4.娘，冷，水都冻冰了……5.要想人前权贵，必得人后受罪6.蝶衣，你可真是不疯魔不成活呀! 唱戏得疯魔，不假，可要是活着也疯魔，在这人世上，在这凡人堆里，咱们可怎么活呀7.人，得自个儿成全自个儿。8.虞姬跟霸王说话中间还得隔条乌江那？9.一个个都他妈忠臣良将的摸样，这日本兵就在城外头，打去呀，敢情欺侮的还是中国人！10.这虞姬再怎么演,她总有一死不是？11.这条小蛇可是你把他给捂活的，如今人家修炼成龙了，这能不顺着他吗？12.我是假霸王，你是真虞姬！13. 小尼姑年方二八，正青春被师傅削去了头发。我本是女娇娥，又不是男儿郎。。。14. 京剧说白了就八个字：无声不歌，无动不舞。15.那个青木，他是懂戏的。。 青木要是活着，京戏就传到日本国去了。16.一个人有一个人的命17.都是下九流，谁嫌弃谁呀!黄天霸和妓女的戏不会演，师傅没教过…… 19.从一而终。20.那林黛玉她不焚稿她叫什么林黛玉啊？",
                           @"高兴的时候凑在一块 分手的时候也惆怅。演戏的 赢得掌声彩声 也赢得他华美的生活。看戏的 花一点钱 买来别人绚漫凄切的故事 赔上自己的感动 打发了一晚 大家都一样 天天的合 天天的分 到了曲终人散 只偶尔地 相互记起。其他辰光 因为事忙 谁也不把谁放在心上。"
                           ];
    
    NSArray *commentsArray = @[@"自个儿成全自个儿",
                               @"你是真虞姬",
                               @"我是假霸王",
                               @"都是下三流,谁嫌弃谁?",
                               @"磨刀子",
                               @"😄",
                               @"😢 ",
                               @"黄天霸和妓女的戏不会演，师傅没教过…… ",
                               @"无声不歌，无动不舞",
                               @"这条小蛇可是你把他给捂活的，如今人家修炼成龙了，这能不顺着他吗？",
                               @"我本是女娇娥，又不是男儿郎。",
                               @"说的是一辈子！差一年，一个月，一天，一个时辰，都不算一辈子！",
                               @"一笑万古春，一啼万古愁，此景非你莫有，此貌非你莫属。"];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        XDCircleOfFriendsCellModel *model = [XDCircleOfFriendsCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            XDCircleOfFriendsCellCommentItemModel *commentItemModel = [XDCircleOfFriendsCellCommentItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItemsArray = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *tempLikes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            XDCircleOfFriendsCellLikeItemModel *model = [XDCircleOfFriendsCellLikeItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            model.userName = namesArray[index];
            model.userId = namesArray[index];
            [tempLikes addObject:model];
        }
        
        model.likeItemsArray = [tempLikes copy];
        
        
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

#pragma mark tableView delegate dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XDCircleOfFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    if (!cell) {
        cell = [[XDCircleOfFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTimeLineTableViewCellId];
    }
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            XDCircleOfFriendsCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath) {
            weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentId];
            weakSelf.currentEditingIndexthPath = indexPath;
            [weakSelf.textField becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.commentToUser = commentId;
            [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
        }];
        
        cell.delegate = self;
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XDCircleOfFriendsCell class] contentViewWidth:[self cellContentViewWith]];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*** 单元格内容视图使用 ***/
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
/*** 滚动视图将开始拖动 ***/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
    _textField.placeholder = nil;
}

#pragma mark - XDCircleOfFriendsDelegate

///自定制cell方法
/*** 赞按钮 ***/
-(void)didClickLikeButtonInCell:(UITableViewCell *)cell {
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    XDCircleOfFriendsCellModel *model = self.dataArray[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeItemsArray];
    
    if (!model.isLiked) {
        XDCircleOfFriendsCellLikeItemModel *likeModel = [XDCircleOfFriendsCellLikeItemModel new];
        likeModel.userName = @"肆水丶";
        likeModel.userId = @"肆水";
        [temp addObject:likeModel];
        model.liked = YES;
    } else {
        XDCircleOfFriendsCellLikeItemModel *tempLikeModel = nil;
        for (XDCircleOfFriendsCellLikeItemModel *likeModel in model.likeItemsArray) {
            if ([likeModel.userId isEqualToString:@"肆水"]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        model.liked = NO;
    }
    model.likeItemsArray = [temp copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    });
}
/*** 评论按钮 ***/
-(void)didClickcCommentButtonInCell:(UITableViewCell *)cell {
    [_textField becomeFirstResponder];
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    [self adjustTableViewToFitKeyboard];
}
/*** 调整的UITableView以适合键盘 ***/
- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}
/*** 调整表视图以适合键盘采用矩形 ***/
- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}
#pragma mark UItextFieldDelegate
/*** 键盘通知 ***/
- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}

/*** textField 返回文本字段的方法 ***/
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
        XDCircleOfFriendsCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
        XDCircleOfFriendsCellCommentItemModel *commentItemModel = [XDCircleOfFriendsCellCommentItemModel new];
        
        if (self.isReplayingComment) {
            commentItemModel.firstUserName = @"肆水丶";
            commentItemModel.firstUserId = @"肆水丶";
            commentItemModel.secondUserName = self.commentToUser;
            commentItemModel.secondUserId = self.commentToUser;
            commentItemModel.commentString = textField.text;
            
            self.isReplayingComment = NO;
        } else {
            commentItemModel.firstUserName = @"肆水丶";
            commentItemModel.commentString = textField.text;
            commentItemModel.firstUserId = @"肆水丶";
        }
        [temp addObject:commentItemModel];
        model.commentItemsArray = [temp copy];
        [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
        _textField.text = @"";
        _textField.placeholder = nil;
        
        return YES;
    }
    return NO;
}

@end

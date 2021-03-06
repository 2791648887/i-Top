//
//  MessageViewController.m
//  itop
//
//  Created by huangli on 2018/3/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageStore.h"
#import "MessageDataSource.h"
#import "DirectMessagesViewController.h"

@interface MessageViewController ()

@property(strong, nonatomic)MessageDataSource *messageDataSource;

@end

static NSString *const MessageCellIdentifier = @"Message";

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"消息";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)refreshData{
    
    [[UserManager shareUserManager]messageList];
    [UserManager shareUserManager].messageListSuccess = ^(NSArray  *obj){
      
        [self listDataWithListArray:[[MessageStore shearMessageStore]configurationUserMessegeMenuWithMenu:obj] page:self.page_no];
//        NSArray * arr = obj;
    };
    
    [UserManager shareUserManager].errorFailure = ^(id obj){
        
        [self tableViewEndRefreshing];
    };
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.top.mas_equalTo(self.view);
    }];
    [self steupTableView];
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(MessageTableViewCell *cell , UserMessege *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        
    };
    self.messageDataSource = [[MessageDataSource alloc]initWithItems:self.dataArray cellIdentifier:MessageCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.messageDataSource
                        cellIdentifier:MessageCellIdentifier
                               nibName:@"MessageTableViewCell"];
    
    self.tableView.dataSource = self.messageDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"MessageTableViewCell"] forCellReuseIdentifier:MessageCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    UserMessege *message = [_messageDataSource itemAtIndexPath:indexPath];
    DirectMessagesViewController *vc = [[DirectMessagesViewController alloc]init];
    vc.otherUser_id = message.user_id;
    vc.otherUser_name = message.nickname;
    [UIManager pushVC:vc];
}



@end

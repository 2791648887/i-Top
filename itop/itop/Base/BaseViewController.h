//
//  BaseViewController.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL hasData;
@property (nonatomic, assign) NSInteger showViewType;
@property (nonatomic, strong) UIView *hideView;
@property (nonatomic, strong) UIImageView *showImg;
@property (nonatomic, strong) UILabel *tipsLab;

- (void)initView;
- (void)initNavigationBarItems;
- (void)initData;
- (void)back;
- (void)hiddenNavigationController:(BOOL)animated;
- (void)hiddenNavigafindHairlineImageView:(BOOL)animated;
//-(UIImageView *)findHairlineImageViewUnder:(UIView *)view;

@end
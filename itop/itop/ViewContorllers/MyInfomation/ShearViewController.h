//
//  ShearViewController.h
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@interface ShearViewController : BaseViewController

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType;
- (instancetype)initWithType:(UMSocialPlatformType)type;
- (void)shareWithType:(UMS_SHARE_TYPE)type;

@end

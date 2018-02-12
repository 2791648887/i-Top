//
//  UserManager.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ArticleType) { //文章类型
    ArticleTypeDefault = 0, //资讯
    ArticleTypeH5 = 1,//H5List
    ArticleTypeVideo,//H5视频
    ArticleTypeOther//其他
};

typedef NS_ENUM(NSInteger, GetArticleListType) { //获取文章入口
    GetArticleListTypeHot = 0, //热点获取
    GetArticleListTypeFocus = 1,//收藏获取
};

typedef NS_ENUM(NSInteger, H5ProductType) { //H5作品类型
    H5ProductTypeDefault = 0, //默认
    H5ProductTypeScenario = 1,//场景H5
    H5ProductTypeSinglePage,//单页
    H5ProductTypeVideo//H5视频
};

typedef NS_ENUM(NSInteger, TagH5ListType) { //TagH5作品类型
    TagH5ListDefault = 0, //默认
    TTagH5ListProduct = 1,//作品
    TTagH5ListArticle ,//热点
    TTagH5ListTrade ,//行业
    TTagH5ListField ,//领域  《设计师用》
};

typedef NS_ENUM(NSInteger, TagType) { //首页Tag类型
    TagTypeDefault = 0, //默认
    TagTypeProduct = 1,//作品
    TagTypeArticle,//热点
    TagTypeTrade,//行业
    TagTypeField //领域
};

typedef NS_ENUM(NSInteger, MyProductType) {  //我的作品类型
    MyProductTypeDefault = 0, //默认
    MyProductTypeScenario = 1,//场景H5
    MyProductTypeSinglePage,//单页
    MyProductTypeVideo//H5视频
};

typedef NS_ENUM(NSInteger, DesignerListType) {  // 获取设计师list入口
    DesignerListTypeHome = 0, //首页获取
    DesignerListTypeFocus = 1,//我关注的设计师
};

typedef NS_ENUM(NSInteger, FocusType) {  //关注用户状态
     FocusTypeTypeCancelFocus = 0, //未关注
     FocusTypeFocus = 1,//关注
};

typedef NS_ENUM(NSInteger, CollectionType) { //收藏文章状态
     CollectionTypeCancelCollection = 0, //未收藏
     CollectionTypeCollection = 1,//收藏
};

typedef void (^LoginSuccess)(id obj);
typedef void (^LoginFailure)(id obj);
typedef void (^VerificationSuccess)(id obj);
typedef void (^VerificationFailure)(id obj);
typedef void (^RegisteredSuccess)(id obj);
typedef void (^RegisteredFailure)(id obj);
typedef void (^UserInfoSuccess)(id obj);
typedef void (^UserInfoFailure)(id obj);
typedef void (^UpdataInfoSuccess)(id obj);
typedef void (^UpdataInfoFailure)(id obj);
typedef void (^ResetPasswordSuccess)(id obj);
typedef void (^ResetPasswordFailure)(id obj);

typedef void (^HomeH5ListSuccess)(id obj);
typedef void (^HomeH5ListFailure)(id obj);
typedef void (^HomeTagListSuccess)(id obj);
typedef void (^HomeTagListFailure)(id obj);
typedef void (^TagListSuccess)(id obj);
typedef void (^TagListFailure)(id obj);

typedef void (^FocusOnUserSuccess)(id obj);
typedef void (^FocusOnUserFailure)(id obj);
typedef void (^CollectionOnHotSuccess)(id obj);
typedef void (^CollectionOnHotFailure)(id obj);

typedef void (^DesignerlistSuccess)(id obj);
typedef void (^DesignerlistFailure)(id obj);
typedef void (^DesignerDetailSuccess)(id obj);
typedef void (^DesignerDetailFailure)(id obj);
typedef void (^DesignerProductListSuccess)(id obj);
typedef void (^DesignerProductListFailure)(id obj);

typedef void (^HotlistSuccess)(id obj);
typedef void (^HotlistFailure)(id obj);
typedef void (^HotDetailSuccess)(id obj);
typedef void (^HotDetailFailure)(id obj);
typedef void (^ProductDetailSuccess)(id obj);
typedef void (^ProductDetailFailure)(id obj);
typedef void (^HotCommentSuccess)(id obj);
typedef void (^HotCommentFailure)(id obj);
typedef void (^CommentHotSuccess)(id obj);
typedef void (^CommentHotFailure)(id obj);

typedef void (^HomeBannerSuccess)(id obj);
typedef void (^HomeBannerFailure)(id obj);
typedef void (^MyProductListSuccess)(id obj);
typedef void (^MyProductListFailure)(id obj);
typedef void (^LeaveProductSuccess)(id obj);
typedef void (^LeaveProductFailure)(id obj);


typedef void (^ErrorFailure)(id obj);


@interface UserManager : NSObject
/*----------------全局错误信息————————————————————————*/
@property (nonatomic, copy) ErrorFailure  errorFailure;

/*----------------登录————————————————————————*/
@property (nonatomic, copy) LoginSuccess loginSuccess;
@property (nonatomic, copy) LoginFailure loginFailure;

/*----------------获取验证码————————————————————————*/
@property (nonatomic, copy) VerificationSuccess verificationSuccess;
@property (nonatomic, copy) VerificationFailure verificationFailure;

/*----------------注册————————————————————————*/
@property (nonatomic, copy) RegisteredSuccess registeredSuccess;
@property (nonatomic, copy) RegisteredFailure registeredFailure;
/*----------------获取个人信息————————————————————————*/
@property (nonatomic, copy) UserInfoSuccess userInfoSuccess;
@property (nonatomic, copy) UserInfoFailure userInfoFailure;
/*----------------更新个人信息————————————————————————*/
@property (nonatomic, copy) UpdataInfoSuccess updataInfoSuccess;
@property (nonatomic, copy) UpdataInfoFailure updataInfoFailure;

/*----------------重置密码————————————————————————*/
@property (nonatomic, copy) ResetPasswordSuccess resetPasswordSuccess;
@property (nonatomic, copy) ResetPasswordFailure resetPasswordFailure;
/*----------------关注用户————————————————————————*/
@property (nonatomic, copy) FocusOnUserSuccess focusOnUserSuccess;
@property (nonatomic, copy) FocusOnUserFailure focusOnUserFailure;
/*----------------收藏热点————————————————————————*/
@property (nonatomic, copy) CollectionOnHotSuccess collectionOnHotSuccess;
@property (nonatomic, copy) CollectionOnHotFailure collectionOnHotFailure;
/*----------------首页H5————————————————————————*/
@property (nonatomic, copy) HomeH5ListSuccess homeH5ListSuccess;
@property (nonatomic, copy) HomeH5ListFailure homeH5ListFailure;
/*----------------首页Tag————————————————————————*/
@property (nonatomic, copy) HomeTagListSuccess homeTagListSuccess;
@property (nonatomic, copy) HomeTagListFailure homeTagListFailure;
/*----------------TagList————————————————————————*/
@property (nonatomic, copy) TagListSuccess tagListSuccess;
@property (nonatomic, copy) TagListFailure tagListFailure;

/*----------------设计师列表————————————————————————*/
@property (nonatomic, copy) DesignerlistSuccess designerlistSuccess;
@property (nonatomic, copy) DesignerlistFailure designerlistFailure;

/*----------------设计师详情————————————————————————*/
@property (nonatomic, copy) DesignerDetailSuccess designerDetailSuccess;
@property (nonatomic, copy) DesignerDetailFailure designerDetailFailure;
/*----------------设计师作品列表————————————————————————*/
@property (nonatomic, copy) DesignerProductListSuccess designerProductListSuccess;
@property (nonatomic, copy) DesignerProductListFailure designerProductListFailure;

/*----------------热点列表————————————————————————*/
@property (nonatomic, copy) HotlistSuccess hotlistSuccess;
@property (nonatomic, copy) HotlistFailure hotlistFailure;
/*----------------热点详情————————————————————————*/
@property (nonatomic, copy) HotDetailSuccess hotDetailSuccess;
@property (nonatomic, copy) HotDetailFailure hotDetailFailure;
/*----------------作品预览详情————————————————————————*/
@property (nonatomic, copy) ProductDetailSuccess productDetailSuccess;
@property (nonatomic, copy) ProductDetailFailure productDetailFailure;
/*----------------热点评论列表————————————————————————*/
@property (nonatomic, copy) HotCommentSuccess hotCommentSuccess;
@property (nonatomic, copy) HotCommentFailure hotCommentFailure;
/*----------------评论热点————————————————————————*/
@property (nonatomic, copy) CommentHotSuccess commentHotSuccess;
@property (nonatomic, copy) CommentHotFailure commentHotFailure;

/*----------------Home轮播图————————————————————————*/
@property (nonatomic, copy) HomeBannerSuccess homeBannerSuccess;
@property (nonatomic, copy) HomeBannerFailure homeBannerFailure;

/*----------------我的作品————————————————————————*/
@property (nonatomic, copy) MyProductListSuccess myProductListSuccess;
@property (nonatomic, copy) MyProductListFailure myProductListFailure;

/*----------------作品留资————————————————————————*/
@property (nonatomic, copy) LeaveProductSuccess leaveProductSuccess;
@property (nonatomic, copy) LeaveProductFailure LeaveProductFailure;

+ (instancetype)shareUserManager;

/**
 *  判断用户是否登录
 *
 *  @return YSE or No
 */
- (BOOL)isLogin;

/**
 *  用户登录
 *
 *  @param userName 用户帐号
 *  @param password 密码
 */
- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)password;

/**
 *  用户登出
 *
 */
-(void)loginOut;

/**
 *  获取验证码
 *
 *  @param phone 手机号码
 */
- (void)getVerificationCodeWithPhone:(NSString *)phone;

/**
 *  注册
 *
 *  @param userName 用户帐号
 *  @param password 密码
 *  @param verificationCode 验证码
 */
- (void)registeredWithUserName:(NSString *)userName
                      passWord:(NSString *)password
              verificationCode:(NSString *)verificationCode;

/**
 *  获取用户信息
 *
 */
- (void)userInfomation;

/**
 *  注册
 *
 *  @param parameters 需要修改的itme
 */
- (void)updataInfoWithKeyValue:(NSDictionary *)parameters;

/**
 *  重置
 *
 *  @param userName 用户帐号
 *  @param password 密码
 *  @param verificationCode 验证码
 */
- (void)resetPasswordWithUserName:(NSString *)userName
                         passWord:(NSString *)password
                 verificationCode:(NSString *)verificationCode;
/**
 *  关注用户
 *
 *  @param user_id 用户id
 */
- (void)focusOnUserWithUserId:(NSString *)user_id focusType:(FocusType)focusType;

/**
 *  收藏热点
 *
 *  @param hot_id 用户id
 *  @param collectionType 收藏／取消
 */
- (void)collectionOnHotWithHotId:(NSString *)hot_id
                  CollectionType:(CollectionType)collectionType;


/**
 *  首页H5
 *
 *  @param type H5类型
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)homeH5ListWithType:(H5ProductType )type
                 PageIndex:(NSInteger )pageIndex
                 PageCount:(NSInteger )pageCount;

/**
 *  tagList
 *
 *  @param type tag类型
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)tagH5ListWithType:(TagH5ListType )type
                PageIndex:(NSInteger )pageIndex
                PageCount:(NSInteger )pageCount;

/**
 *  首页Tag
 *
 *  @param type Tag类型
 */
- (void)hometagListWithType:(TagType )type;

/**
 *  首页轮播图
 *
 */
- (void)homeBanner;

/**
 *  设计师列表
 *
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)designerlistWithPageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount
                 designerListType:(DesignerListType)designerListType;
/**
 *  设计师详情
 *
 *  @param designer_id 设计师ID
 */
- (void)designerDetailWithDesigner:(NSString *)designer_id;

/**
 *  设计师作品列表
 *
 *  @param designer_id 设计师ID
 */
- (void)designerProductListWithDesigner:(NSString *)designer_id
                              PageIndex:(NSInteger )pageIndex
                              PageCount:(NSInteger )pageCount;

/**
 *  热点列表
 *
 *  @param type 文章类型
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 *  @param getArticleListType 获取入口  热点／收藏
 */
- (void)hotListWithType:(ArticleType )type
              PageIndex:(NSInteger )pageIndex
              PageCount:(NSInteger )pageCount
     getArticleListType:(GetArticleListType)getArticleListType;

/**
 *  热点详情
 *
 *  @param detail_id 热点详情 id
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)hotDetailWithHotDetailId:(NSString *)detail_id
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;
/**
 *  作品详情
 *
 *  @param detail_id 详情 id
 */
- (void)productDetailWithHotDetailId:(NSString *)detail_id;

/**
 *  获取热点评论列表
 *
 *  @param detail_id 热点详情 id
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)hotCommentWithHotDetailId:(NSString *)detail_id
                        PageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount;

/**
 *  获取热点评论列表
 *
 *  @param Article_id 文章 id
 *  @param parent_id 回复评论ID
 *  @param content 回复内容
 */
- (void)commentHotWithHotArticleId:(NSString *)Article_id
                          parentId:(NSString *)parent_id
                          content:(NSString *)content;

/**
 *  我的作品
 *
 *  @param Product_type 作品详情
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)myProductListWithProductType:(MyProductType )Product_type
                           PageIndex:(NSInteger )pageIndex
                           PageCount:(NSInteger )pageCount;

/**
 *  作品留资
 *
 *  @param product_id 作品详情
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)leaveProductWithProductId:(NSString *)product_id
                        PageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount;



@end
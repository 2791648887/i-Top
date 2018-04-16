//
//  ReleaseHotViewController.m
//  itop
//
//  Created by huangli on 2018/3/16.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ReleaseHotViewController.h"
#import "SegmentTapView.h"
#import "CompanySigningStore.h"
#import "MyhotViewController.h"

@interface ReleaseHotViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate,SubmitFileManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;
@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dataArray;
@property (strong, nonatomic )NSArray *views;
@property (strong, nonatomic) CAShapeLayer *currentInfoShapeLayer;
@property (strong, nonatomic) CAShapeLayer *currentH5ShapeLayer;

/*资讯*/
@property (weak, nonatomic) IBOutlet UITextView *titleInfoTV;
@property (weak, nonatomic) IBOutlet UIButton *addInfoImage;
@property (weak, nonatomic) IBOutlet UIButton *submitInfoButton;
@property (weak, nonatomic) IBOutlet UITextView *contentInfoTV;
/*H5*/
@property (weak, nonatomic) IBOutlet UITextView *titleH5TV;
@property (weak, nonatomic) IBOutlet UIButton *addH5Image;
@property (weak, nonatomic) IBOutlet UIButton *submitH5Button;
@property (weak, nonatomic) IBOutlet UITextView *contentH5TV;
@property (weak, nonatomic) IBOutlet UIScrollView *h5ScrollView;
@property (strong, nonatomic) UIImageView *h5_cover;
@property (strong, nonatomic) H5List *select_h5;

@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong) NSArray *provinceArray; // 省份
@property (nonatomic, strong) NSArray *cityArray;//城市
@property (nonatomic, strong) Province *province; //选择省份
@property (nonatomic, strong) Province *city; //选择的城市
@property (assign, nonatomic) SignPickViewType signPickViewType;
@property (weak, nonatomic) IBOutlet UIButton *h5SelectProvinceButton;
@property (weak, nonatomic) IBOutlet UIButton *infoSelectProvinceButton;

@end

@implementation ReleaseHotViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    _views = [[NSBundle mainBundle] loadNibNamed:@"ReleaseHotViewController" owner:self options:nil];
    self.view = [_views firstObject];
    _itmeIndex = 0;
    
    if (_releaseHotType == ReleaseHotTypeAdd) {   //发布
        
        [self initSegment];
        [self.view addSubview:self.segment];
        [self setupH5SubViews];
        [self setupInfoSubViews];
        
    } else { //编辑
        
        if (_itemDetailType == H5ItemDetailType) {
            
             [self setupH5SubViews];
            self.view  = _views[0];
        } else {
            
            [self setupInfoSubViews];
            self.view  = _views[1];
        }
        
        _itmeIndex = _itemDetailType;
    }
  
    [SubmitFileManager sheardSubmitFileManager].delegate = self;
//    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_addH5Image];
    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_addInfoImage];
    [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"发布热点";
}

-(void)initData{
    
    self.dataArray = [NSArray arrayWithObjects:@"H5",@"资讯", @"视频", nil];
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;

}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 40) withDataArray:self.dataArray withFont:15];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
}

-(void)setupH5SubViews{

    if (_releaseHotType == ReleaseHotTypeAdd) {
    
        _titleH5TV.placeholder = @"请输入文章标题最多20字";
        _contentH5TV.placeholder = @"请输入H5内容说明";
        _currentH5ShapeLayer = [[Global sharedSingleton] buttonSublayerWithButton:_addH5Image];
        [_addH5Image.layer addSublayer:_currentH5ShapeLayer];
  
    } else {
        
        _titleH5TV.text = _hotDetail.article.title;
        _contentH5TV.text = _hotDetail.article.content;
        
        UIImageView *imv = [[UIImageView alloc]init];
        [imv sd_setImageWithURL:[NSURL URLWithString:_hotDetail.article.cover_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [_addH5Image setImage:imv.image forState:UIControlStateNormal];
        }];
        _select_h5 = [[H5List alloc]init];
        _select_h5.url = _hotDetail.article.url;
        _select_h5.cover_img = _hotDetail.article.cover_img;

    }
    _h5ScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeigh-40);
//    _h5ScrollView.shouldHideToolbarPlaceholder = NO;
    [_submitH5Button.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitH5Button)];
    _submitH5Button.layer.cornerRadius = _submitH5Button.height/2;
    _submitH5Button.layer.masksToBounds = YES;
  
}

-(void)setupInfoSubViews{
    
    if (_releaseHotType == ReleaseHotTypeAdd) {
        _titleInfoTV.placeholder = @"请输入文章标题最多20字";
        _contentInfoTV.placeholder = @"请输入H5内容说明";
//        [_submitInfoButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitInfoButton)];
//        _submitInfoButton.layer.cornerRadius = _submitInfoButton.height/2;
//        _submitInfoButton.layer.masksToBounds = YES;
        _currentInfoShapeLayer = [[Global sharedSingleton] buttonSublayerWithButton:_addInfoImage];
        [_addInfoImage.layer addSublayer:_currentInfoShapeLayer];

    } else {
        
        _titleInfoTV.text = _hotDetail.article.title;
        _contentInfoTV.text = _hotDetail.article.content;
        
        UIImageView *imv = [[UIImageView alloc]init];
        [imv sd_setImageWithURL:[NSURL URLWithString:_hotDetail.article.cover_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [_addInfoImage setImage:imv.image forState:UIControlStateNormal];
        }];
    }
    
    [_submitInfoButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitInfoButton)];
    _submitInfoButton.layer.cornerRadius = _submitInfoButton.height/2;
    _submitInfoButton.layer.masksToBounds = YES;
}

- (IBAction)selectItem:(UIButton *)sender {
    
    [self showAlertViewWithItem:sender];
}

-(void)showAlertViewWithItem:(UIButton*)button{
    
    _signPickViewType = button.tag;
    UIView *view = [[UIView alloc] init];
    [self initPickViewWith:button.tag];
    view.frame = self.pickView.frame;
    [view addSubview:self.pickView];

    AlertView *alertView = [[AlertView alloc]initWithTitle:@"请选择地区"
                                                   message:view
                                                   sureBtn:@"确定"
                                                 cancleBtn:@"取消"
                                              pickViewType:button.tag];
    alertView.resultIndex = ^(NSInteger index ,PickViewType picViewType){
        
        
        if (_itmeIndex == 0) {
            
            [_h5SelectProvinceButton setTitle:[NSString stringWithFormat:@"%@,%@",_province.address,_city.address] forState:UIControlStateNormal];
        } else {
            
            [_infoSelectProvinceButton setTitle:[NSString stringWithFormat:@"%@,%@",_province.address,_city.address] forState:UIControlStateNormal];
        }
    };
    
//    alertView.alertCancel = ^ (NSInteger index ,PickViewType picViewType){
//    
//        
//        
//    };
    [alertView showXLAlertView];
}

-(void)initPickViewWith:(SignPickViewType)pickViewType{
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    [self.pickView reloadAllComponents];
    
    if (_itmeIndex == 0) {
        
        [self positioningwithindex:_h5SelectProvinceButton.titleLabel.text];
 
    } else {
        
       [self positioningwithindex:_infoSelectProvinceButton.titleLabel.text];
    }
}


#pragma mark 数据源 Method numberOfComponentsInPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        //在这里设置字体相关属性
        lbl.adjustsFontSizeToFitWidth = YES;
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.textColor = [UIColor blackColor];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setBackgroundColor:[UIColor clearColor]];
    }
    //重新加载lbl的文字内容
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return lbl;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0){ //省
        
        return self.provinceArray.count;
    }else{
        //市
        return _cityArray.count;
    }
}

#pragma mark delegate 显示信息的方法

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0){
        
        
        Province *province = self.provinceArray[row];
        _province = province;
        return province.address;
        
    }else{
        Province *city = self.cityArray[row];
        _city = city;
        return city.address;//省份对应的市区
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0){
        
        _province = self.provinceArray[row];
        self.cityArray =_province.cityArray;
        [self.pickView reloadComponent:1];
        
    }else{
        
        _city = self.cityArray[row];
    }
}


#pragma mark 选择数据时将有数据的itme赋给已选择的temp
-(void)positioningwithindex:(NSString *)info{
    
    NSArray *arr = [info componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (Province *province in self.provinceArray ) {
        
        if ([province.address isEqualToString:arr[0]]) {
            
            index = [self.provinceArray indexOfObject:province];
            self.cityArray = province.cityArray;
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
    
    if (arr.count > 1) {
        
        for (Province *province in self.cityArray ) {
            
            if ([province.address isEqualToString:arr[1]]) {
                
                inde2 = [self.cityArray indexOfObject:province];
            }
        }
        [self.pickView selectRow:inde2 inComponent:1 animated:NO];
    }
}



#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{

    _itmeIndex = index;
    self.view  = _views[index];
    [self.view addSubview:self.segment];
    if (index > 1) {
       
        self.originY = 50;
        [self setHasData:NO];
    }
}

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
   
    if (_itmeIndex == 0) {
        if (array.count == 0) {
            
            [_addH5Image setImage:[UIImage imageNamed:@"ruzhu_icon_add"] forState:UIControlStateNormal];
            [_addH5Image.layer addSublayer:_currentH5ShapeLayer];
            
        }else {
            
            [_currentH5ShapeLayer removeFromSuperlayer];
            [_addH5Image setImage:[array lastObject] forState:UIControlStateNormal];
        }
    } else {
        if (array.count == 0) {
            
            [_addInfoImage setImage:[UIImage imageNamed:@"ruzhu_icon_add"] forState:UIControlStateNormal];
            [_addInfoImage.layer addSublayer:_currentInfoShapeLayer];
            
        }else {
            
            [_currentInfoShapeLayer removeFromSuperlayer];
            [_addInfoImage setImage:[array lastObject] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)addImage:(UIButton *)sender {
   
    if (sender.tag == 1) {
        
        [UIManager productViewControllerWithType:GetProductListTypeSelect];
        [UIManager sharedUIManager].selectProductBolck = ^(H5List *h5){
            
            _select_h5 = h5;
            _h5_cover = [[UIImageView alloc]init];
            [_h5_cover sd_setImageWithURL:[NSURL URLWithString:h5.cover_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [_addH5Image setImage:_h5_cover.image forState:UIControlStateNormal];
                [_currentH5ShapeLayer removeFromSuperlayer];
                
            }];
        };
    }else {
        
        [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
    }
}

- (IBAction)subMitHot:(UIButton *)sender {
    
    if (sender.tag == 1) {
       
        [self submitH5Hot];

    } else {
       
        [self submitInfoHot];
    }
}

-(void)submitH5Hot{
    
    if ([Global stringIsNullWithString:_titleH5TV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"标题")];
        return;
    }
    if ([Global stringIsNullWithString:_contentH5TV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"内容")];
        return;
    }
    
    if (_select_h5.url == nil ) {
        
        [self showToastWithMessage:TIPSMESSEGEADD(@"作品")];
        return;
    }
    
    if([_h5SelectProvinceButton.titleLabel.text isEqualToString:TIPSMESSEGESELECT(@"地区")]){
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"地区")];
        return;
    }
    
    NSString *fileUrl = [NSString stringWithFormat:@"%@",_select_h5.cover_img];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:fileUrl forKey:@"Cover_img"];
    [parameters setObject:_titleH5TV.text forKey:@"Title"];
    [parameters setObject:_contentH5TV.text forKey:@"Content"];
    [parameters setObject:@(1) forKey:@"Article_type"];
    [parameters setObject:_select_h5.url forKey:@"Url"];
    [parameters setObject:_city.code forKey:@"city_code"];

    if (_releaseHotType == ReleaseHotTypeAdd) {
        
//        [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
//        [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
        
        
            [[UserManager shareUserManager]addHotListWithParameters:parameters];
            [UserManager shareUserManager].addHotSuccess =  ^(id obj){
                
                [self alertOperation];
            };
        
    } else {
        
        [parameters setObject:_hotDetail.article.id forKey:@"Id"];
        [[UserManager shareUserManager]updateHotListWithParameters:parameters];
        [UserManager shareUserManager].addHotSuccess =  ^(id obj){
            
            [self updateAlertOperation];
        };
    }
    
//    [UIManager showVC:@"HotBusinessCircleController"];
    
}

-(void)submitInfoHot{
    
    if ([Global stringIsNullWithString:_titleInfoTV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"标题")];
        return;
    }
    if ([Global stringIsNullWithString:_contentInfoTV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"内容")];
        return;
    }
    
    if ([_addInfoImage.imageView.image isEqual:[UIImage imageNamed:@"ruzhu_icon_add"]]) {
        
        [self showToastWithMessage:TIPSMESSEGEADD(@"文件")];
        return;
    }
    
    if([_infoSelectProvinceButton.titleLabel.text isEqualToString:TIPSMESSEGESELECT(@"地区")] ){
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"地区")];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:_titleInfoTV.text forKey:@"Title"];
    [parameters setObject:_contentInfoTV.text forKey:@"Content"];
    [parameters setObject:@(0) forKey:@"Article_type"];
    [parameters setObject:_city.code forKey:@"city_code"];
    
    if (_releaseHotType == ReleaseHotTypeAdd) {
        
        [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
        [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
            
            NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
            [parameters setObject:fileUrl forKey:@"Cover_img"];

            [[UserManager shareUserManager]addHotListWithParameters:parameters];
            [UserManager shareUserManager].addHotSuccess =  ^(id obj){
                
                [self alertOperation];
            };
        };
    } else {
        
        [parameters setObject:_hotDetail.article.id forKey:@"Id"];
        if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count != 0) {
        
            [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
            [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
                
                NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
                [parameters setObject:fileUrl forKey:@"Cover_img"];

                [[UserManager shareUserManager]updateHotListWithParameters:parameters];
                [UserManager shareUserManager].addHotSuccess =  ^(id obj){
                    
                    [self updateAlertOperation];
                };
            };
        } else {
            
            [parameters setObject:_hotDetail.article.cover_img forKey:@"Cover_img"];
            [[UserManager shareUserManager]addHotListWithParameters:parameters];
            [UserManager shareUserManager].addHotSuccess =  ^(id obj){
                
                [self updateAlertOperation];
            };

        }
    }
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"热点提交成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续提交" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
        [UIManager sharedUIManager].realesHotBackOffBolck( @(_itmeIndex));
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)updateAlertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"热点修改成功" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续提交" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[MyhotViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        
//        [self back];
        [UIManager sharedUIManager].updateHotBackOffBolck( @(_itmeIndex));
    }];
//    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

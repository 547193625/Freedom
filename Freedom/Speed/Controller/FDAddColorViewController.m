//
//  FDAddColorViewController.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDAddColorViewController.h"
#import "FDColorPickerView.h"
#import "FDFavoriteColorView.h"
#import "FDLightSlideView.h"
#import "FDTextFiled.h"
#import "FDColorModel.h"



@interface FDAddColorViewController ()<UITextFieldDelegate,FDColorPickerViewDelegate,FDFavoriteColorViewDelegate,FDLightSlideViewDelegate>
@property(nonatomic, strong) FDColorPickerView *colorPickerView;
@property(nonatomic, strong) FDFavoriteColorView *favoriteView;
@property(nonatomic, strong) FDNormalTextField *nameTextField;
@property(nonatomic, strong) FDLightSlideView *lightSlideView;
@property(nonatomic, strong) UIView *tipView;
@property(nonatomic, strong) NSString *nameStr;
@property(nonatomic, assign) NSInteger  x;
@property(nonatomic, assign) NSInteger  y;
@property(nonatomic, assign) NSInteger  item;
@property(nonatomic, assign) BOOL isAdd;
@end

@implementation FDAddColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configAddColorUI];
}


-(void)configAddColorUI{
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = Color_FFFFFF;
    self.navigationItem.title = @"选择颜色主题";
    UIBarButtonItem *saveItem = [UIBarButtonItem itemWithTitle:@"保存" selTitle:@"保存" titleColor:Color_FFFFFF backgroundColor:[UIColor clearColor] target:self action:@selector(saveItemClick)];
    self.navigationItem.rightBarButtonItem = saveItem;
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.colorPickerView];

    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.view);
       make.top.equalTo(self.view.mas_top).offset(12);
       make.size.mas_offset(CGSizeMake(kScreenWidth - 34, 36));
    }];
    

    
    

    
    // 初始化数据
    [self initColorData];
    

    FDFavoriteColorView *favoriteView = [[FDFavoriteColorView alloc] initWithFrame:CGRectMake(0, self.colorPickerView.bottom, kScreenWidth , 110) preSelectColorArray:self.selectColorArray];
    self.favoriteView = favoriteView;
    favoriteView.delegate = self;
    [self.view addSubview:favoriteView];
    
    // 指示器
    self.tipView.center = CGPointMake(kScreenWidth/(self.selectColorArray.count * 2), 250);
    self.tipView.size = CGSizeMake(15, 68);
    [self.view addSubview:self.tipView];
    
    [self.view addSubview:self.lightSlideView];
    [self.lightSlideView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.view);
       make.top.equalTo(self.favoriteView.mas_bottom).offset(0);
       make.size.mas_offset(CGSizeMake(kScreenWidth, 102));
    }];
}



#pragma mark - 保存
-(void)saveItemClick{
    if (self.nameStr.length == 0) {
        [self showToastText:@"请输入主题名"];
        return;
    }
    if (self.selectColorArray.count == 1) {
        [self showToastText:@"请添加主题颜色"];
        return;
    }
}


#pragma mark - FDColorPickerViewDelegate
- (void)getCurrentColor:(UIColor *)color {
    if (self.isAdd == YES) { //添加
        FDColorModel *model = [[FDColorModel alloc] init];
        model.color = color;
        model.x = self.x;
        model.y = self.y;
        
        [self.selectColorArray insertObject:model atIndex:self.selectColorArray.count - 1];
        NSInteger arrayCount = self.selectColorArray.count;
        DebugLog(@"count__%zd",self.selectColorArray.count);
        [self.favoriteView updateSelectedColor:self.selectColorArray];
        
        self.tipView.hidden = NO;
        NSInteger count = 0;
        if (arrayCount == 9) {
            count = kScreenWidth - (kScreenWidth / (arrayCount - 1)) * 0.5;
        }else{
            count = kScreenWidth - (kScreenWidth / arrayCount) * 1.5;
        }
        [self addAnimationColor:color Count:count];
        
    }else{ //更新选中的颜色
        FDColorModel *colorModel = self.selectColorArray[self.item];
        colorModel.color = color;
        self.tipView.backgroundColor = color;
        [self.favoriteView updateSelectedColorModel:colorModel];
    }
}


#pragma mark - FDFavoriteColorViewDelegate
-(void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView item:(NSInteger)item{
    self.isAdd = YES;
    NSInteger  x = [self getRandomNumber:0 to:kScreenWidth];
    NSInteger  y = [self getRandomNumber:0 to:[self Suit:180]];
    self.x = x;
    self.y = y;
    [self.colorPickerView updateDragButtonPoint:CGPointMake(x, y)];
}

-(void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView array:(nonnull NSMutableArray<FDColorModel *> *)array item:(NSInteger)item{
    if (array.count == 1) {
        self.tipView.hidden = YES;
        return;
    }
    FDColorModel *colorModel = array[item];
    DebugLog(@"item__%zd",item);
    NSInteger arrayCount = item;
    NSInteger count = 0;
    if (arrayCount == 9) {
        count = kScreenWidth - (kScreenWidth / (arrayCount - 1)) * 0.5;
    }else{
        count = (kScreenWidth / array.count) * (item + 0.5);
    }
    [self addAnimationColor:colorModel.color Count:count];


}

// 更改颜色
-(void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView colorModel:(FDColorModel *)colorModel item:(NSInteger)item array:(NSMutableArray<FDColorModel *> *)array{
    self.item = item;
    self.isAdd = NO;
    [self.colorPickerView updateSelectDragButtonColor:CGPointMake(colorModel.x, colorModel.y)];
    NSInteger count = 0;
    if (item == 0) {
        count = (kScreenWidth / array.count) * 0.5;
    }else{
        count = (kScreenWidth / array.count) * (item + 0.5);
    }
    [self addAnimationColor:colorModel.color Count:count];
}

#pragma mark - 亮度数值
-(void)lightSlideView:(FDLightSlideView *)LightSlideView slider:(UISlider *)slider{
    DebugLog(@"value_%f",slider.value);
}


#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeDefault;
    return YES;
}

-(void)nameChange:(UITextField *)textField{
    self.nameStr = textField.text;
}




#pragma mark - 指示器移动动画
-(void)addAnimationColor:(UIColor *)color Count:(NSInteger)count{
    self.tipView.backgroundColor = color;
    //创建动画对象
   CABasicAnimation *basicAni = [CABasicAnimation animation];
   //设置动画属性
   basicAni.keyPath = @"position";
   //设置动画的起始位置。也就是动画从哪里到哪里
   basicAni.fromValue = [NSValue valueWithCGPoint:self.tipView.center];
   //动画结束后，layer所在的位置
   basicAni.toValue = [NSValue valueWithCGPoint:CGPointMake(count, self.tipView.center.y)];
   self.tipView.center = CGPointMake(count, self.tipView.center.y);
   //动画持续时间
   basicAni.duration = 0.2;
   //动画填充模式
   basicAni.fillMode = kCAFillModeForwards;
   //动画完成不删除
   basicAni.removedOnCompletion = YES;
   //把动画添加到要作用的Layer上面
   [self.tipView.layer addAnimation:basicAni forKey:nil];
}

/**
 适配 给定375屏尺寸，适配320和414屏尺寸
 */
- (float)Suit:(float)MySuit {
    IS_WIDTH320 ? (MySuit = MySuit / Suit320Width) : (IS_WIDTH414 ? (MySuit = MySuit * Suit414Width) : MySuit);
    return MySuit;
}

-(int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}


- (void)initColorData{
    NSMutableArray *selectArray = [NSMutableArray arrayWithCapacity:0];
    {
        FDColorModel *model = [FDColorModel new];
        model.color = [UIColor redColor];
        model.x = 30;
        model.y = 10;
        model.item = 0;
        [selectArray addObject:model];
    }
    {
        FDColorModel *model = [FDColorModel new];
        [selectArray addObject:model];
    }


    self.selectColorArray = selectArray;
}


#pragma mark - lazy load
-(FDColorPickerView *)colorPickerView{
    if (!_colorPickerView) {
        _colorPickerView =  [[FDColorPickerView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, [self Suit:180])];
        _colorPickerView.delegate = self;
    }
    return _colorPickerView;
}

-(FDNormalTextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[FDNormalTextField alloc]init];
        _nameTextField.backgroundColor = AppBackgroundColor;
        _nameTextField.placeholder = @"请输入颜色主题";
        [NSObject addCornerRadiu:_nameTextField cornerWith:2];
        _nameTextField.delegate = self;
        [_nameTextField addTarget:self action:@selector(nameChange:)forControlEvents:UIControlEventAllEditingEvents];
    }
    return _nameTextField;
}

- (UIView *)tipView{
    if (!_tipView) {
        _tipView = [[UIView alloc] init];
        _tipView.backgroundColor = [UIColor redColor];
        [NSObject addCornerRadiu:_tipView cornerWith:18.0];
        _tipView.userInteractionEnabled = NO;
    }
    return _tipView;
}
-(FDLightSlideView *)lightSlideView{
    if (!_lightSlideView) {
        _lightSlideView = [[FDLightSlideView alloc] init];
        _lightSlideView.delegate  = self;
    }
    return _lightSlideView;
}

@end

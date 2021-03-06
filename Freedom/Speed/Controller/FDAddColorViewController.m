//
//  FDAddColorViewController.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDAddColorViewController.h"
#import "FDColorPickerView.h"
#import "FDFavoriteColorView.h"
#import "FDTextFiled.h"

@interface FDAddColorViewController ()<UITextFieldDelegate,FDColorPickerViewDelegate,FDFavoriteColorViewDelegate>
@property(nonatomic, strong) FDColorPickerView *colorPickerView;
@property(nonatomic, strong) FDFavoriteColorView *favoriteView;
@property(nonatomic, strong) FDNormalTextField *nameTextField;
@property(nonatomic, strong) NSString *nameStr;
@end

@implementation FDAddColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configAddColorUI];
}


-(void)configAddColorUI{
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
    
    self.selectColorArray = [NSMutableArray arrayWithArray:@[[UIColor redColor],[UIColor greenColor]]];
    FDFavoriteColorView *favoriteView = [[FDFavoriteColorView alloc] initWithFrame:CGRectMake(0, self.colorPickerView.bottom,kScreenWidth , 110) preSelectColorArray:self.selectColorArray];
    self.favoriteView = favoriteView;
    favoriteView.delegate = self;
    [self.view addSubview:favoriteView];
    
}



#pragma mark - 保存
-(void)saveItemClick{
    
}

#pragma mark - FDColorPickerViewDelegate
- (void)getCurrentColor:(UIColor *)color {
    [self.selectColorArray addObject:color];
    [self.favoriteView updateSelectedColor:self.selectColorArray];
}


#pragma mark -- FDFavoriteColorViewDelegate
-(void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView addBtn:(UIButton *)addBtn{
    NSInteger  x = [self getRandomNumber:0 to:kScreenWidth];
    NSInteger  y = [self getRandomNumber:0 to:[self Suit:180]];
    [self.colorPickerView updateDragButtonPoint:CGPointMake(x, y)];
}



#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeDefault;
    return YES;
}

-(void)nameChange:(UITextField *)textField{
    self.nameStr = textField.text;
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

@end

//
//  FDChooseColorViewController.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDChooseColorViewController.h"

@interface FDChooseColorViewController ()

@end

@implementation FDChooseColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configChooseColorUI];
}

-(void)configChooseColorUI{
    self.navigationItem.title = @"选择颜色主题";
    UIBarButtonItem *right = [UIBarButtonItem itemWithImage:FDImage(@"theme_color_add")  highImage:FDImage(@"theme_color_add") target:self action:@selector(addColorClick)];
    self.navigationItem.rightBarButtonItem = right;

}

-(void)addColorClick{
    
}
@end

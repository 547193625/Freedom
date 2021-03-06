//
//  FDTextFiled.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDTextFiled.h"
#import <objc/runtime.h>

@implementation FDTextFiled

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if ([self isKindOfClass:[FDNormalTextField class]]) {
            self.secureTextEntry = NO;
            self.tintColor = Color_3d78f2;
        }
        self.textColor = Color_333333;
        self.font = Font_14;
        if (![self isKindOfClass:[FDNumberTextField class]]) {
            UIButton *button = [self valueForKey:@"_clearButton"];
                 [button setImage:[UIImage imageNamed:@"edit_clear"] forState:UIControlStateNormal];
                 self.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!CGRectContainsPoint(self.bounds, point)) {
        [self resignFirstResponder];
    }
    
    return [super hitTest:point withEvent:event];
}

// 设置背景字体的属性
-(void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    placeholderLabel.textColor = Color_b6b6b6;
    placeholderLabel.font = Font_14;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, bounds.size.width, bounds.size.height);
}



@end



@implementation FDNormalTextField

//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

@end

@implementation FDNumberTextField

@end

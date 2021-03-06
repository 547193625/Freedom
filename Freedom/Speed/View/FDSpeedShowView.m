//
//  FDSpeedShowView.m
//  Freedom
//
//  Created by Andrew on 2021/1/23.
//

#import "FDSpeedShowView.h"


@interface FDSpeedShowView()
@property (nonatomic, weak) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *addLayer;
@property (nonatomic, strong) CALayer *needleLayer;
@property (nonatomic, strong) UIButton *addBtn;


@end

@implementation FDSpeedShowView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AppBackgroundColor;
        [self setUpSpeedShowViewUI];
    }
    return self;
}


-(void)setUpSpeedShowViewUI{
    
    // 外环弧线
    CAShapeLayer *outArc = [self drawCurveWithRadius:self.width - 80];
    [self.layer addSublayer:outArc];
    
    CAGradientLayer *gradientLayer = [self drawCurveWithColorArray:[NSArray arrayWithObjects:
                                   (id)[RGBA(159,192, 250, 1) CGColor],
                                   (id)[RGBA(147,140, 255, 1) CGColor],
                                   nil]];
    
     [self.layer addSublayer:gradientLayer];
    
    // 绘制刻度
    CGFloat perAngle = M_PI / 30; // 一刻度的弧度值
    CGFloat calWidth = perAngle / 5; // 刻度线的宽度
    
    for (int i = 1; i< 30; i++) {
        
        CGFloat startAngel = -M_PI + perAngle * i;
        CGFloat endAngel   = startAngel + calWidth;
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width, self.height)
                                                                radius:self.width - 82
                                                            startAngle:startAngel
                                                              endAngle:endAngel
                                                             clockwise:YES];
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        
        if (i % 5 == 0) { //整数
            
            perLayer.strokeColor = [[UIColor whiteColor] CGColor];
            perLayer.lineWidth   = 10.f;
            
            CGPoint point = [self calculateTextPositonWithArcCenter:CGPointMake(self.width, self.height) angle:-startAngel];
            
            UILabel *calibration       = [[UILabel alloc] initWithFrame:CGRectMake(point.x - 20, point.y - 20, 20, 20)];
            calibration.text           = [NSString stringWithFormat:@"%d", i/5];
            calibration.font           = Bold_Font(16);
            calibration.textColor      = Color_649CF0;
            calibration.textAlignment  = NSTextAlignmentCenter;
            [self addSubview:calibration];
            
        }else{
            // 小刻度
            perLayer.strokeColor = [[UIColor whiteColor] CGColor];
            perLayer.lineWidth   = 5;
        }
        
        perLayer.path = tickPath.CGPath;
        
        [self.layer addSublayer:perLayer];
    }
    
    

    
    // 指针
    [self.layer addSublayer:self.needleLayer];
    
    

    [self.layer addSublayer:self.addLayer];
    [self addSubview:self.addBtn];
    
 
}



// 加速度
-(void)setAccelerationX:(CGFloat)accelerationX{
    _accelerationX = accelerationX;
    dispatch_async(dispatch_get_main_queue(), ^{
        [CATransaction begin];
        [CATransaction setDisableActions:NO];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        self.needleLayer.transform = CATransform3DMakeRotation((M_PI/50)*fabs(accelerationX * 30) + (-M_PI_2), 0, 0, 1);
        [CATransaction commit];
    });


}

/**
 绘制弧线
 
 @param radius 半径
 @return CAShapeLayer
 */
- (CAShapeLayer *)drawCurveWithRadius:(CGFloat)radius{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width, self.height)
                                                        radius:radius
                                                    startAngle:-M_PI
                                                      endAngle:-M_PI_2
                                                     clockwise:YES];
    CAShapeLayer *curve = [CAShapeLayer layer];
    curve.lineWidth     = 3.f;
    curve.fillColor     = [[UIColor clearColor] CGColor];
    curve.strokeColor   = [[UIColor whiteColor] CGColor];
    curve.path          = path.CGPath;
    return curve;
}

/**
 计算Label位置
 
 @param center 中心点
 @param angel 角度
 @return CGPoint
 */
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center angle:(CGFloat)angel
{
    CGFloat calRadius = self.width - 80; // 刻度Label中心点所在圆弧的半径
    CGFloat x = calRadius * cosf(angel);
    CGFloat y = calRadius * sinf(angel);
    
    return CGPointMake(center.x + x, center.y - y);
}

// 图层颜色数组
-(CAGradientLayer *)drawCurveWithColorArray:(NSArray *)colorArray{
    // 绘制进度图层
    UIBezierPath *progressPath  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width, self.height)
                                                                 radius:self.width - 90
                                                             startAngle:-M_PI
                                                               endAngle:-M_PI_2
                                                              clockwise:YES];
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.lineWidth     =  20.f;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];
    progressLayer.strokeColor   = [[UIColor whiteColor] CGColor];
    progressLayer.path          = progressPath.CGPath;
    progressLayer.strokeStart   = 0.0;
    progressLayer.strokeEnd     = 1.0;
    [self.layer addSublayer:progressLayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:colorArray];
    [gradientLayer setLocations:@[@0, @0.5,  @1]];
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    [gradientLayer setMask:progressLayer];
    return gradientLayer;
}

// 添加
-(void)addBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showView:addBtn:)]) {
        [self.delegate showView:self addBtn:btn];
       }
    
}


#pragma mark - lazy load
-(CAShapeLayer *)addLayer{
    if (!_addLayer) {
        UIBezierPath *addPath  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width, self.height)
                                                                     radius:20
                                                                 startAngle:-M_PI
                                                                   endAngle:-M_PI_2
                                                                  clockwise:YES];
        _addLayer = [CAShapeLayer layer];
        _addLayer.lineWidth     =  90.0f;
        _addLayer.fillColor     = [[UIColor whiteColor] CGColor];
        _addLayer.strokeColor   = [[UIColor whiteColor] CGColor];
        _addLayer.path          = addPath.CGPath;
        _addLayer.strokeStart   = 0.0;
        _addLayer.strokeEnd     = 1.0;
        _addLayer.shadowColor = RGBA(166, 157, 253, 0.4).CGColor;
        _addLayer.shadowOffset = CGSizeMake(0,-0.5);
        _addLayer.shadowOpacity = 1;
        _addLayer.shadowRadius = 7.5;
    }
    return _addLayer;
}
- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(self.width - 35, self.height - 40, 24, 24);
        [_addBtn setImage:FDImage(@"speed_add_icon")forState:UIControlStateNormal];
        [_addBtn setImage:FDImage(@"speed_add_icon") forState:UIControlStateSelected];
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(CALayer *)needleLayer{
    if (!_needleLayer) {
        // 指针
        _needleLayer = [CALayer layer];
        // 设置锚点
        _needleLayer.anchorPoint = CGPointMake(1, 1);
        // 锚点位置
        _needleLayer.position = CGPointMake(self.width,self.height-20);
        // bounds
        _needleLayer.bounds = CGRectMake(0, 0, 29, self.width - 105);
        // 添加图片
        _needleLayer.contents = (id)[UIImage imageNamed:@"speed_zhen_icon"].CGImage;
        _needleLayer.contentsRect = CGRectMake(0, 0, 1, 1.0);
        _needleLayer.contentsGravity = kCAGravityResizeAspect;
        _needleLayer.magnificationFilter = kCAFilterNearest;
        _needleLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
    }
    return _needleLayer;
}
@end

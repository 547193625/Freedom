//
//  FDColorPickerView.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDColorPickerView.h"
#import "MSDragButton.h"

@interface FDColorPickerView ()

@property (nonatomic, strong) MSDragButton *dragButton;//中间的图片

@end

@implementation FDColorPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initConfig];
        [self buildColorPicker];
    }
    return self;
}

- (void)initConfig {
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildColorPicker {
    UIImageView *palette = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colormap"]];
    [self addSubview:palette];
    [palette mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_offset(self.bounds.size.width);
        make.height.mas_equalTo(self.bounds.size.height);
    }];
    self.dragButton = [MSDragButton buttonWithType:UIButtonTypeCustom];
    [self.dragButton setImage:[UIImage imageNamed:@"indicator"] forState:UIControlStateNormal];
    [self.dragButton setImage:[UIImage imageNamed:@"indicator"] forState:UIControlStateSelected];
    self.dragButton.cagingArea = self.bounds;
    self.dragButton.remainStyle = MSDragButtonRemainStyleNone;
    [self addSubview:self.dragButton];
    [self.dragButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo([self Suit:40]);
    }];
    @weakify(self);
    self.dragButton.panBtnComplete = ^(CGFloat x, CGFloat y) {
        @strongify(self)
        CGPoint currentPoint = CGPointMake(x, y);
        UIColor *color = [self getPixelColorAtLocation:currentPoint];
        if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]) {
            [self.delegate getCurrentColor:color];
        }
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    self.dragButton.center =  currentPoint;
    UIColor *color = [self getPixelColorAtLocation:currentPoint];
    if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]) {
        [self.delegate getCurrentColor:color];
    }

}

// 随机坐标位置
-(void)updateDragButtonPoint:(CGPoint)point{
    self.dragButton.center =  point;
    UIColor *color = [self getPixelColorAtLocation:point];
    if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]) {
        [self.delegate getCurrentColor:color];
    }
}


-(void)updateSelectDragButtonColor:(CGPoint )point{
    self.dragButton.center =  point;
}



- (UIColor*)getPixelColorAtLocation:(CGPoint)point {
    UIColor *color = nil;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef inImage = viewImage.CGImage;
    
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) {
        return nil;
    }
    
    size_t w = self.bounds.size.width;
    size_t h = self.bounds.size.height;
    
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    unsigned char *data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }
    CGContextRelease(cgctx);
    if (data) { free(data); }
    
    return color;
}


- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef)inImage {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    size_t pixelsWide = self.bounds.size.width;
    size_t pixelsHigh = self.bounds.size.height;

    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL) {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }

    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    CGColorSpaceRelease( colorSpace );
    
    return context;
}



/**
 适配 给定375屏尺寸，适配320和414屏尺寸
 */
- (float)Suit:(float)MySuit {
    IS_WIDTH320 ? (MySuit = MySuit / Suit320Width) : (IS_WIDTH414 ? (MySuit = MySuit * Suit414Width) : MySuit);
    return MySuit;
}

/**
 适配 给定375屏字号，适配320和414屏字号
 */
- (float)SuitFont:(float)font {
    IS_WIDTH320 ? (font = font - 1) : (IS_WIDTH414 ? (font = font + 1) : font);
    return font;
}


@end

//
//  Macros.h
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#ifndef Macros_h
#define Macros_h

//**************************************************************************************************
//                                             屏幕比例相关以及缩放系数
//**************************************************************************************************
#define kScreenWidth           [UIScreen mainScreen].bounds.size.width
#define kScreenHeight          [UIScreen mainScreen].bounds.size.height
//缩放系数 以iphone6为标准
#define iPhone_6_Width_Zoom     kScreenWidth/375.0
#define iPhone_6_Height_Zoom    kScreenHeight/667.0

#define HSLineWidth             (1/[UIScreen mainScreen].scale)

//iphonex ------------------------
//是否是iPhoneX的刘海屏
#define Is_Iphone                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define YYISiPhoneX              (kScreenWidth >=375.0f && kScreenHeight >=812.0f && Is_Iphone)

//状态栏高度
#define kStatusBarHeight    (CGFloat)(YYISiPhoneX?(44):(20))
// 导航栏高度
#define kNavBarHBelow7      (44)
// 状态栏和导航栏总高度
#define kNavBarHAbove7      (CGFloat)(YYISiPhoneX?(88):(64))
// TabBar高度
#define kTabBarHeight      (CGFloat)(YYISiPhoneX?(49+34):(49))
// 顶部安全区域远离高度
#define kTopBarSafeHeight  (CGFloat)(YYISiPhoneX?(44):(0))
// 底部安全区域远离高度
#define kBottomSafeHeight  (CGFloat)(YYISiPhoneX?(34):(0))
// iPhoneX的状态栏高度差值
#define kTopBarDifHeight    (CGFloat)(YYISiPhoneX?(44):(20))

#define kTopBarMakeHeight    (CGFloat)(YYISiPhoneX?(24):(0))


#define NONNULLSTRING(str)      ((str == nil || [str isEqualToString:@""] || [str isKindOfClass:[NSNull class]]) ? @"" : str)



//**************************************************************************************************
//                                             颜色宏定义
//**************************************************************************************************

//MARK:--------------颜色--------------
#define FDColor(rgbValue)       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a)           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define SYSTEM_VERSION_GRETER_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending


// BLE Color
#define AppBackgroundColor              FDColor(0xEBEEF3)
#define seperatorLineColor              FDColor(0xededed)   //线条颜色
#define Color_FFFFFF    FDColor(0xFFFFFF)
#define Color_fafafa    FDColor(0xfafafa)
#define Color_1f1f1f    FDColor(0x1f1f1f)
#define Color_242022    FDColor(0x242022)
#define Color_58bd78    FDColor(0x58bd78)
#define Color_407cf7    FDColor(0x407cf7)
#define Color_3d78f2    FDColor(0x3d78f2)
#define Color_3a3a3a    FDColor(0x3a3a3a)
#define Color_222222    FDColor(0x222222)
#define Color_212121    FDColor(0x212121)
#define Color_737373    FDColor(0x737373)
#define Color_7b7b7b    FDColor(0x7b7b7b)
#define Color_b6b6b6    FDColor(0xb6b6b6)
#define Color_b9b9b9    FDColor(0xb9b9b9)
#define Color_eeeeee    FDColor(0xeeeeee)
#define Color_aaaaaa    FDColor(0xaaaaaa)
#define Color_68b1fc    FDColor(0x68b1fc)
#define Color_a6a6a6    FDColor(0xa6a6a6)
#define Color_3699ff    FDColor(0x3699ff)
#define Color_727174    FDColor(0x727174)
#define Color_7c7c7c    FDColor(0x7c7c7c)
#define Color_d2d2d2    FDColor(0xd2d2d2)
#define Color_d4d4d4    FDColor(0xd4d4d4)
#define Color_dcdcdc    FDColor(0xdcdcdc)
#define Color_c7c7c7    FDColor(0xc7c7c7)
#define Color_dadada    FDColor(0xdadada)
#define Color_8f8f8f    FDColor(0x8f8f8f)
#define Color_b4b4b4    FDColor(0xb4b4b4)
#define Color_f2573d    FDColor(0xf2573d)
#define Color_bfbfbf    FDColor(0xbfbfbf)
#define Color_d82222    FDColor(0xd82222)
#define Color_8969d9    FDColor(0x8969D9)
#define Color_3d78f2    FDColor(0x3d78f2)


#define Color_D8D8D8    FDColor(0xD8D8D8)
#define Color_4D88E0    FDColor(0x4D88E0)








//**************************************************************************************************
//                                             字体宏定义
//**************************************************************************************************

#define FDFont(font)                [UIFont systemFontOfSize:font]
#define FDFont_Scale(font)          [UIFont systemFontOfSize:font * iPhone_6_Width_Zoom]

#define Bold_Font(font)             [UIFont fontWithName:@"Helvetica-Bold" size:font]
#define Bold_Scale_Font(font)       [UIFont fontWithName:@"Helvetica-Bold" size:font * iPhone_6_Width_Zoom]

//MARK:--------------字体大小--------------
#define Font_6 FDFont(6)
#define Font_7 FDFont(7)
#define Font_8 FDFont(8)
#define Font_9 FDFont(9)
#define Font_10 FDFont(10)
#define Font_11 FDFont(11)
#define Font_12 FDFont(12)
#define Font_13 FDFont(13)
#define Font_14 FDFont(14)
#define Font_15 FDFont(15)
#define Font_16 FDFont(16)
#define Font_17 FDFont(17)
#define Font_18 FDFont(18)
#define Font_19 FDFont(19)
#define Font_20 FDFont(20)

#define Font_Scale_6   FDFont(6 * iPhone_6_Width_Zoom)
#define Font_Scale_7   FDFont(7 * iPhone_6_Width_Zoom)
#define Font_Scale_8   FDFont(8 * iPhone_6_Width_Zoom)
#define Font_Scale_9   FDFont(9 * iPhone_6_Width_Zoom)
#define Font_Scale_10  FDFont(10 * iPhone_6_Width_Zoom)
#define Font_Scale_11  FDFont(11 * iPhone_6_Width_Zoom)
#define Font_Scale_12  FDFont(12 * iPhone_6_Width_Zoom)
#define Font_Scale_13  FDFont(13 * iPhone_6_Width_Zoom)
#define Font_Scale_14  FDFont(14 * iPhone_6_Width_Zoom)
#define Font_Scale_15  FDFont(15 * iPhone_6_Width_Zoom)
#define Font_Scale_16  FDFont(16 * iPhone_6_Width_Zoom)
#define Font_Scale_17  FDFont(17 * iPhone_6_Width_Zoom)
#define Font_Scale_18  FDFont(18 * iPhone_6_Width_Zoom)
#define Font_Scale_19  FDFont(19 * iPhone_6_Width_Zoom)
#define Font_Scale_20  FDFont(20 * iPhone_6_Width_Zoom)

//MARK:--------------设置图片--------------
#define FDImage(imagename)          [UIImage imageNamed:imagename]


#define kUserDefault [NSUserDefaults standardUserDefaults]
#define launchFlag @"isFirstLaunch"//是否第一次启动

//设置是否调试模式
#define VrDEBUG 1

#if VrDEBUG
#define DebugLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DebugLog(xx, ...)  ((void)0)
#endif // #ifdef DEBUG


//MARK:--Block self
#define WeakSelf    __weak typeof(self) weakSelf = self;
#define StrongSelf  __strong typeof(weakSelf) strongSelf = weakSelf;

/**
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 * 示例：
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#endif /* Macros_h */

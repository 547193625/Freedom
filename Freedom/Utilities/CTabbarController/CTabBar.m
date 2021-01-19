//
//  CTabBar.m
//  CustomTabbarController
//
//  Created by Liu Jiang on 2017/9/27.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import "CTabBar.h"
#import "UIButton+Style.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define MaxItemNum 5
#define ContentEdgeLeft 2
#define ItemSpacing 0
#define ImageTitleSpacing 2
@interface CTabBar ()
@property (nonatomic, strong)UIFont *font;
@property (nonatomic, strong)UIFont *selectedFont;
@property (nonatomic, strong)UIColor *normalColor;
@property (nonatomic, strong)UIColor *selectetColor;
@property (nonatomic, strong)UIButton *lastSelectedItem;
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)NSMutableArray *tabBarItems;///存 button
@property (nonatomic, assign)BOOL isSetEdgeInsets;

//@property (nonatomic, strong)NSArray *selectedImageArray;
@end
@implementation CTabBar///007aff
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.width = frame.size.width != ScreenWidth ? ScreenWidth : frame.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (NSMutableArray *)tabBarItems {
    if (!_tabBarItems) {
        _tabBarItems = [NSMutableArray arrayWithCapacity:0];
    }
    return _tabBarItems;
}

- (void)setFrame:(CGRect)frame {
    if (frame.size.height == 0) {
        return;
    }
    if (frame.size.width != ScreenWidth) {
        frame.size.width = ScreenWidth;
    }
    if (self.bgImageView && CGRectEqualToRect(self.bgImageView.frame, CGRectZero)) {
        self.bgImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self adjustFrame];
    }
    [super setFrame:frame];
}
- (void)_init {
    self.clipsToBounds = NO;
    _font = [UIFont systemFontOfSize:10];
    _selectedFont = [UIFont systemFontOfSize:10];
    _normalColor = [UIColor grayColor];
    _selectetColor = [UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1];
    _isBeyondLimit = NO;
    _offset = UIOffsetZero;
    _isSetEdgeInsets = NO;
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 0, self.frame.size.width - 32, self.frame.size.height)];
    _bgImageView.userInteractionEnabled = YES;
    [self addSubview:_bgImageView];
}
- (void)setOffset:(UIOffset)offset {
    _offset = offset;
    [self adjustFrame];
}

- (void)setTabBarItemsArray:(NSArray<NSString *> *)tabBarItemsArray {
    if (!_tabBarItemsArray) {
        _tabBarItemsArray = tabBarItemsArray;
    }else if (_tabBarItemsArray.count > tabBarItemsArray.count) {
        NSMutableArray *temp = [_tabBarItemsArray mutableCopy];
        [temp replaceObjectsInRange:NSMakeRange(0, tabBarItemsArray.count) withObjectsFromArray:tabBarItemsArray];
        _tabBarItemsArray = [temp copy];
    }else {
        NSMutableArray *temp = [_tabBarItemsArray mutableCopy];
        [temp replaceObjectsInRange:NSMakeRange(0, _tabBarItemsArray.count) withObjectsFromArray:tabBarItemsArray range:NSMakeRange(0, _tabBarItemsArray.count)];
        _tabBarItemsArray = [temp copy];
    }
    [self layoutTabBarItems:_tabBarItemsArray];
    
}
- (void)setTabBarItemsImageArray:(NSArray<NSString *> *)tabBarItemsImageArray {
    _tabBarItemsImageArray = tabBarItemsImageArray;
    [self setTabBarItemsImage];
}
- (void)setTabBarItemsImageSelectedArray:(NSArray<NSString *> *)tabBarItemsImageSelectedArray {
    _tabBarItemsImageSelectedArray = tabBarItemsImageSelectedArray;
    [self setTabBarItemsSelectedImage];
}
- (void)setLastSelectedItem:(UIButton *)lastSelectedItem {
    _lastSelectedItem = lastSelectedItem;
}
//bar 背景色
- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        [self addSubview:_bgImageView];
    }
    _bgImageView.backgroundColor = _barTintColor;
    [self wantToClearSuperView];
}
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        [self addSubview:_bgImageView];
    }
    _bgImageView.image = backgroundImage;
    [self wantToClearSuperView];
}
- (void)setTextAttributes:(NSDictionary *)attributes state:(UIControlState)state {
    if (state == UIControlStateNormal) {
        if (attributes[NSFontAttributeName]) {
            _font = attributes[NSFontAttributeName];
        }
        if (attributes[NSForegroundColorAttributeName]) {
            _normalColor = attributes[NSForegroundColorAttributeName];
        }
    }else if (state == UIControlStateSelected) {
        if (attributes[NSFontAttributeName]) {
            _selectedFont = attributes[NSFontAttributeName];
        }
        if (attributes[NSForegroundColorAttributeName]) {
            _selectetColor = attributes[NSForegroundColorAttributeName];
        }
    }
    [self resetTitleTextApperance];
}

- (void)addChildItemWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    if (title.length < 1 && image.length < 1) {
        return;
    }
    NSMutableArray *titles, *images, *selectedImages;
    if (!_tabBarItemsArray) {
        _tabBarItemsArray = [NSArray array];
    }
    if (!_tabBarItemsImageArray) {
        _tabBarItemsImageArray = [NSArray array];
    }
    if (!_tabBarItemsImageSelectedArray) {
        _tabBarItemsImageSelectedArray = [NSArray array];
    }
    if (title.length < 1) {
        title = @"";
    }
    if (image.length < 1) {
        image = @"";
    }
    if (selectedImage.length < 1) {
        selectedImage = @"";
    }
    
    titles =[_tabBarItemsArray mutableCopy];
    images = [_tabBarItemsImageArray mutableCopy];
    selectedImages = [_tabBarItemsImageSelectedArray mutableCopy];
    
    [titles addObject:title];
    [images addObject:image];
    [selectedImages addObject:selectedImage];
    _tabBarItemsArray = [titles copy];
    _tabBarItemsImageArray = [images copy];
    _tabBarItemsImageSelectedArray = [selectedImages copy];
    
    [self addItem];
}

- (void)layoutTabBarItems:(NSArray *)tabBarItemsArray {
    [self adjustFrame];
    [self removeSubItems];
    CGFloat itemWidth = 0.f;
//    NSMutableArray *itemsArray = [NSMutableArray arrayWithCapacity:0];
    if (tabBarItemsArray.count > MaxItemNum) {
        itemWidth = (ScreenWidth - ContentEdgeLeft*2 - 4*ItemSpacing) / 5.f;
        _isBeyondLimit = YES;
    }else {
        itemWidth = (ScreenWidth - ContentEdgeLeft*2 - (tabBarItemsArray.count-1)*ItemSpacing - 32) / tabBarItemsArray.count;
        _isBeyondLimit = NO;
    }
    
    if (_isBeyondLimit) {
        [self sendBeyondMessage];
        for (int i = 0; i < MaxItemNum; i++) {
            
            UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tabBarButton.adjustsImageWhenHighlighted = NO;
            [tabBarButton addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
            tabBarButton.frame = CGRectMake(ContentEdgeLeft + i*ItemSpacing + i*itemWidth, 0, itemWidth, CGRectGetHeight(self.frame));
            if (i == 4) {
                [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"更多" attributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
                [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"更多" attributes:@{NSFontAttributeName:_selectedFont, NSForegroundColorAttributeName:_selectetColor}] forState:UIControlStateSelected];
                [tabBarButton setImage:[UIImage imageNamed:@"tabbarBtn_more_nomal"] forState:UIControlStateNormal];
                [tabBarButton setImage:[UIImage imageNamed:@"tabbarBtn_more_selected"] forState:UIControlStateSelected];
                [self.tabBarItems addObject:tabBarButton];
                [tabBarButton layoutButtonWithButtonStyle:ButtonStyleImageTopTitleBottom imageTitleSpace:ImageTitleSpacing];
                [_bgImageView addSubview:tabBarButton];
                continue;
            }
            [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:tabBarItemsArray[i] attributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
            [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:tabBarItemsArray[i] attributes:@{NSFontAttributeName:_selectedFont, NSForegroundColorAttributeName:_selectetColor}] forState:UIControlStateSelected];
            
            if (self.tabBarItemsImageArray.count > 0 && i < self.tabBarItemsImageArray.count) {
                [tabBarButton setImage:[UIImage imageNamed:self.tabBarItemsImageArray[i]] forState:UIControlStateNormal];
            }
            if (self.tabBarItemsImageSelectedArray.count > 0 && i < self.tabBarItemsImageSelectedArray.count) {
                [tabBarButton setImage:[UIImage imageNamed:self.tabBarItemsImageSelectedArray[i]] forState:UIControlStateSelected];
            }
            [tabBarButton layoutButtonWithButtonStyle:ButtonStyleImageTopTitleBottom imageTitleSpace:ImageTitleSpacing];
            [self.tabBarItems addObject:tabBarButton];
            
            [_bgImageView addSubview:tabBarButton];
            
        }
    }else {
        for (int i = 0; i < tabBarItemsArray.count; i++) {
            UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [tabBarButton addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
            tabBarButton.adjustsImageWhenHighlighted = NO;
            tabBarButton.frame = CGRectMake(ContentEdgeLeft + i*ItemSpacing + i*itemWidth, 0, itemWidth, CGRectGetHeight(self.frame));
            [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:tabBarItemsArray[i] attributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
            [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:tabBarItemsArray[i] attributes:@{NSFontAttributeName:_selectedFont, NSForegroundColorAttributeName:_selectetColor}] forState:UIControlStateSelected];
            
            if (self.tabBarItemsImageArray.count > 0 && i < self.tabBarItemsImageArray.count) {
                [tabBarButton setImage:[UIImage imageNamed:self.tabBarItemsImageArray[i]] forState:UIControlStateNormal];
            }
            if (self.tabBarItemsImageSelectedArray.count > 0 && i < self.tabBarItemsImageSelectedArray.count) {
                [tabBarButton setImage:[UIImage imageNamed:self.tabBarItemsImageSelectedArray[i]] forState:UIControlStateSelected];
            }
            [tabBarButton layoutButtonWithButtonStyle:ButtonStyleImageTopTitleBottom imageTitleSpace:ImageTitleSpacing];
            [self.tabBarItems addObject:tabBarButton];
            [_bgImageView addSubview:tabBarButton];

        }
    }
    _lastSelectedItem = self.tabBarItems.firstObject;
    _lastSelectedItem.selected = YES;
}

- (void)addItem {
    if (_tabBarItemsArray.count > MaxItemNum + 1) {
        return;
    }
    
    CGFloat itemWidth = 0.f;
    if (_tabBarItemsArray.count > MaxItemNum) {
        itemWidth = (ScreenWidth - ContentEdgeLeft*2 - 4*ItemSpacing) / 5.f;
        _isBeyondLimit = YES;
    }else {
        itemWidth = (ScreenWidth - ContentEdgeLeft*2 - (_tabBarItemsArray.count-1)*ItemSpacing) / _tabBarItemsArray.count;
        _isBeyondLimit = NO;
    }
    if (_tabBarItemsArray.count == MaxItemNum + 1) {
        UIButton *lastItem = self.tabBarItems.lastObject;
        [lastItem setAttributedTitle:[[NSAttributedString alloc] initWithString:@"更多" attributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
        [lastItem setAttributedTitle:[[NSAttributedString alloc] initWithString:@"更多" attributes:@{NSFontAttributeName:_selectedFont, NSForegroundColorAttributeName:_selectetColor}] forState:UIControlStateSelected];
        [lastItem setImage:[UIImage imageNamed:@"tabbarBtn_more_nomal"] forState:UIControlStateNormal];
        [lastItem setImage:[UIImage imageNamed:@"tabbarBtn_more_selected"] forState:UIControlStateSelected];
        [lastItem layoutButtonWithButtonStyle:ButtonStyleImageTopTitleBottom imageTitleSpace:ImageTitleSpacing];
        return;
    }
    for (int i = 0; i < _tabBarItemsArray.count-1; i++) {
        UIButton *item = self.tabBarItems[i];
        item.frame = CGRectMake(ContentEdgeLeft + i*ItemSpacing + i*itemWidth, 0, itemWidth, CGRectGetHeight(self.frame));
    }
    
    for (int j = (int)_tabBarItemsArray.count-1; j < (int)[_tabBarItemsArray count]; j++) {
        UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tabBarButton addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
        tabBarButton.adjustsImageWhenHighlighted = NO;
        tabBarButton.frame = CGRectMake(ContentEdgeLeft + j*ItemSpacing + j*itemWidth, 0, itemWidth, CGRectGetHeight(self.frame));
        [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:_tabBarItemsArray[j] attributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
        [tabBarButton setAttributedTitle:[[NSAttributedString alloc] initWithString:_tabBarItemsArray[j] attributes:@{NSFontAttributeName:_selectedFont, NSForegroundColorAttributeName:_selectetColor}] forState:UIControlStateSelected];
        
        if (self.tabBarItemsImageArray.count > 0 && j < self.tabBarItemsImageArray.count) {
            [tabBarButton setImage:[UIImage imageNamed:self.tabBarItemsImageArray[j]] forState:UIControlStateNormal];
        }
        if (self.tabBarItemsImageSelectedArray.count > 0 && j < self.tabBarItemsImageSelectedArray.count) {
            [tabBarButton setImage:[UIImage imageNamed:self.tabBarItemsImageSelectedArray[j]] forState:UIControlStateSelected];
        }
        [_bgImageView addSubview:tabBarButton];
        [tabBarButton layoutButtonWithButtonStyle:ButtonStyleImageTopTitleBottom imageTitleSpace:ImageTitleSpacing];
        [self.tabBarItems addObject:tabBarButton];
        
        if (_tabBarItemsArray.count == 1) {
            tabBarButton.selected = YES;
            _lastSelectedItem = tabBarButton;
        }
        
    }
}

- (void)adjustFrame {
    if (self.frame.size.height == 0 || UIOffsetEqualToOffset(_offset, UIOffsetZero) || !_bgImageView) {
        return;
    }
    if (!_isSetEdgeInsets) {
        
        CGRect rect = self.bgImageView.frame;
        rect.origin.x += _offset.horizontal;
        rect.origin.y += _offset.vertical;
        self.bgImageView.frame = rect;
        _isSetEdgeInsets = YES;
    }
}

- (void)setTabBarItemsImage {
    for (UIButton *item in _tabBarItems) {
        NSInteger index = [_tabBarItems indexOfObject:item];
        if (![item imageForState:UIControlStateNormal] && _tabBarItemsImageArray.count > 0 && index < _tabBarItemsImageArray.count) {
            [item setImage:[UIImage imageNamed:_tabBarItemsImageArray[index]] forState:UIControlStateNormal];
            [item layoutButtonWithButtonStyle:ButtonStyleImageTopTitleBottom imageTitleSpace:ImageTitleSpacing];
        }
    }
}
- (void)setTabBarItemsSelectedImage {
    for (UIButton *item in _tabBarItems) {
        NSInteger index = [_tabBarItems indexOfObject:item];
        if (![item imageForState:UIControlStateSelected] && _tabBarItemsImageSelectedArray.count > 0 && index < _tabBarItemsImageSelectedArray.count) {

            [item setImage:[UIImage imageNamed:_tabBarItemsImageSelectedArray[index]] forState:UIControlStateSelected];
            [item layoutButtonWithButtonStyle:ButtonStyleImageTopTitleBottom imageTitleSpace:ImageTitleSpacing];
        }
    }
}
- (void)resetTitleTextApperance {
    for (UIButton *item in _tabBarItems) {
        if (item.titleLabel.text.length > 0) {
            [item setAttributedTitle:[[NSAttributedString alloc] initWithString:item.titleLabel.text attributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
            [item setAttributedTitle:[[NSAttributedString alloc] initWithString:item.titleLabel.text attributes:@{NSFontAttributeName:_selectedFont, NSForegroundColorAttributeName:_selectetColor}] forState:UIControlStateSelected];
        }
    }
}

- (void)didClicked:(UIButton *)sender {
    
    if ([self.delegete respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        NSInteger selectedIndex = [_tabBarItems indexOfObject:sender];
        if (sender != _lastSelectedItem) {
            _lastSelectedItem.selected = !_lastSelectedItem.selected;
            _lastSelectedItem = sender;
            _lastSelectedItem.selected = YES;
        }
        if ([sender.titleLabel.text isEqualToString:@"更多"] && selectedIndex == 4 && _tabBarItemsArray.count > 5) {
            [self clickMoreTabBarButton];
        }
        [self.delegete tabBar:self didSelectItemAtIndex:selectedIndex];
    
    }
}
///////////////////////触发代理
- (void)clickMoreTabBarButton {
    if ([self.delegete respondsToSelector:@selector(gotoExtraViewControllers)]) {
        [self.delegete gotoExtraViewControllers];
    }
}

- (void)wantToClearSuperView {
    if ([self.delegete respondsToSelector:@selector(isSetBarBackgroundColorOrImage)]) {
        [self.delegete isSetBarBackgroundColorOrImage];
    }
}
- (void)sendBeyondMessage {
    if ([self.delegete respondsToSelector:@selector(beyondMaxItemsNumLimit:)]) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (int i = 4; i < self.tabBarItemsArray.count; i++) {
            [array addObject:self.tabBarItemsArray[i]];
        }
        [self.delegete beyondMaxItemsNumLimit:[array copy]];
    }
}



- (void)removeSubItems {
    for (UIView *subview in self.bgImageView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
            _lastSelectedItem = nil;
            [_tabBarItems removeAllObjects];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

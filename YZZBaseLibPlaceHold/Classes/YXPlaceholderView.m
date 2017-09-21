//
//  YXPlaceHolderView.m
//  MyTest
//
//  Created by yaozhengzheng on 2017/8/1.
//  Copyright © 2017年 yaozhengzheng. All rights reserved.
//

#import "YXPlaceholderView.h"
#import <objc/runtime.h>
#import "UIMacros.h"
#import "ColorsMacros.h"
#import "UIView+YXCircleAngle.h"
static void *yx_placeholder = &yx_placeholder;

@interface YXPlaceholderView()
// map表用来存储由外界更改的图片 和 文字
@property (nonatomic, strong) NSMutableDictionary *imagesKeyValues;

@property (nonatomic, strong) NSMutableDictionary *explainKeyValues;

@property (nonatomic, strong) UIImageView *placeholderImageView;

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) UIButton *reloadBtn ;

@end

@implementation YXPlaceholderView

- (UIViewFloatInstance)ignoredScrollViewContentInsetTop
{
    return ^TXINSTANCE_TYPE_RETURN(UIView)(CGFloat y){
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
        return self;
    };
}
- (NSMutableDictionary *)imagesKeyValues
{
    if (!_imagesKeyValues) {
        _imagesKeyValues = [[NSMutableDictionary alloc] init];
    }
    return _imagesKeyValues;
}

- (NSMutableDictionary *)explainKeyValues
{
    if (!_explainKeyValues) {
        _explainKeyValues = [[NSMutableDictionary alloc] init];
    }
    return _explainKeyValues;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupBaseSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self setupBaseSubViews];
    }
    return self;
}

- (UIImageView *)placeholderImageView
{
    if (!_placeholderImageView) {
        _placeholderImageView = [[UIImageView alloc] init];
        _placeholderImageView.userInteractionEnabled = YES;
//        _placeholderImageView.contentMode = UIViewContentModeCenter;
        _placeholderImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_placeholderImageView];
    }
    return _placeholderImageView;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
        _placeholderLabel.userInteractionEnabled = YES;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font = [UIFont systemFontOfSize:13];
        _placeholderLabel.textColor = [UIColor grayColor];
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (UIButton *)reloadBtn
{
    if (!_reloadBtn) {
        self.reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reloadBtn setTitle:@"添加车款" forState:UIControlStateNormal];
        self.reloadBtn.titleLabel.font = font(15);
        [self.reloadBtn setTitleColor:Color99 forState:UIControlStateNormal];
        self.reloadBtn.layer.cornerRadius = 2.5f;
        self.reloadBtn.layer.borderWidth = 1.f;
        self.reloadBtn.layer.borderColor = UIColorFromRGB(0xB2B2B2).CGColor;
        [self.reloadBtn addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.reloadBtn];
    }
    return _reloadBtn;
}

- (void)setupBaseSubViews
{
    self.placeHolderType = YXPlaceholderViewModeDefault;
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    ///在此处更改默认设置
    //暂无数据
    [self setImage:[UIImage imageNamed:@"no_record"] forMode:YXPlaceHolderNorecord];
    [self setExplain:@"暂无数据记录" forMode:YXPlaceHolderNorecord];
    //无网络
    [self setImage:[UIImage imageNamed:@"no-wifi"] forMode:YXPlaceHolderNetWorkError];
    //加载失败
    [self setImage:[UIImage imageNamed:@"load_failed"] forMode:YXPlaceHolderLoadFiled];
    [self setExplain:@"加载失败,请点击重新加载" forMode:YXPlaceHolderLoadFiled];
    
    //没有对比的车型
    [self setImage:[UIImage imageNamed:@"no_record"] forMode:YXPlaceHolderCompare];
    [self setExplain:@"亲，还没有车款进行对比" forMode:YXPlaceHolderCompare];

    [self setImage:[UIImage imageNamed:@"no_record"] forMode:YXPlaceholderViewModeDefault];
    [self setExplain:@"暂无数据记录" forMode:YXPlaceholderViewModeDefault];
}

- (void)setPlaceHolderType:(YXPlaceHolderType)placeHolderType
{
    _placeHolderType = placeHolderType;
    self.hidden = YES;
    self.reloadBtn.hidden = YES;
    
    if (placeHolderType == YXPlaceholderViewModeDefault) return;
    
    if (self.superview) {
        [self.superview bringSubviewToFront:self];
    }
    
    self.placeholderLabel.text = self.explainKeyValues[@(self.placeHolderType)];
    self.placeholderImageView.image = self.imagesKeyValues[@(self.placeHolderType)];
    
    if ([[self btnTitleStrWithType:placeHolderType] isEqualToString:@"hidden"]) {
        self.reloadBtn.hidden = YES;
    } else {
        self.reloadBtn.hidden = NO;
        [self.reloadBtn setTitle:[self btnTitleStrWithType:placeHolderType] forState:UIControlStateNormal];
    }

    [self layoutSubviews];
}

- (void)setImage:(UIImage *)image forMode:(YXPlaceHolderType)type
{
    if (type == YXPlaceholderViewModeDefault) return;
    if (!image) {
        if (self.imagesKeyValues[@(type)]) {
            [self.imagesKeyValues removeObjectForKey:@(type)];
        }
    }
    self.imagesKeyValues[@(type)] = image;
}

- (void)setExplain:(NSString *)explain forMode:(YXPlaceHolderType)type
{
    if (type == YXPlaceholderViewModeDefault) return;
    if (!explain) {
        if (self.explainKeyValues[@(type)]) {
            [self.explainKeyValues removeObjectForKey:@(type)];
        }
        return;
    }
    self.explainKeyValues[@(type)] = explain;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:(self.placeHolderType == YXPlaceholderViewModeDefault)];
}

- (CGRect)explainRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}

// 有点击需要刷新的控件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.update) {
        self.update();
        return;
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)didClickButton:(UIButton *)sender
{
    if (self.update) {
        self.update();
        return;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];

//    [self.placeholderImageView sizeToFit];
    
    CGFloat imageW = 0.0f;
    CGFloat imageH = 0.0f;
    CGFloat imageX = 0.0f;
    CGFloat imageY = 0.0f;
    CGFloat imageCenterY = 200.0f;
    switch (self.placeHolderType) {
        case YXPlaceHolderNone:
        {
            
        }
            break;
        case YXPlaceHolderNetWorkError:
        {
            imageW = 86.0;
            imageH = 52.5;
            imageX = 0;
            imageY = 0;
            imageCenterY = 200.0f;
        }
            break;
        case YXPlaceHolderNorecord:
        case YXPlaceHolderLoadFiled:
        case YXPlaceHolderCompare:
        {
            imageW = 105;
            imageH = 105;
            imageX = 0;
            imageY = 0;
            imageCenterY = 200.0f;
        }
            break;
        default:
            break;
    }
    self.placeholderImageView.frame = [self imageRectForContentRect:CGRectMake(imageX, imageY, imageW, imageH)];
    self.placeholderImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, imageCenterY);

    self.placeholderLabel.frame = [self explainRectForContentRect:CGRectMake(0, CGRectGetMaxY(self.placeholderImageView.frame), self.bounds.size.width, 20)];
    
    self.reloadBtn.frame = CGRectMake(self.bounds.size.width/2-75, CGRectGetMaxY(self.placeholderLabel.frame) + 25, 150, 45);
}

- (NSString *)btnTitleStrWithType:(YXPlaceHolderType)type
{
    NSDictionary *titleStr = @{
                  @(YXPlaceholderViewModeDefault) :@"hidden",
                  @(YXPlaceHolderNone) :@"hidden",
                  @(YXPlaceHolderCompare) :@"添加车款",
                  @(YXPlaceHolderLoadFiled) :@"重新加载",
                  @(YXPlaceHolderNetWorkError) :@"重新加载",
                  @(YXPlaceHolderNorecord) :@"hidden",
                               };
    return titleStr[@(type)];
}
@end

@implementation UIView (YXPlaceholder)

- (__kindof YXPlaceholderView *)yx_placeholderView
{
    return objc_getAssociatedObject(self, yx_placeholder);
}

- (void)setYx_placeholderView:(__kindof YXPlaceholderView *)yx_placeholderView
{
    if (self.yx_placeholderView && self.yx_placeholderView != yx_placeholderView) {
        [self.yx_placeholderView removeFromSuperview];
    }
    [self addSubview:yx_placeholderView];
    objc_setAssociatedObject(self, yx_placeholder, yx_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YXPlaceholderView *)yx_insertPlaceholderView;
{
    self.yx_placeholderView = [[YXPlaceholderView alloc] initWithFrame:self.bounds];
    return self.yx_placeholderView;
}

- (YXPlaceholderView *)yx_networkError
{
    if (!self.yx_placeholderView) return nil;
    [self.yx_placeholderView setExplain:@"加载失败,请点击重新加载" forMode:YXPlaceHolderNetWorkError];
    self.yx_placeholderView.placeHolderType = YXPlaceHolderNetWorkError;
    return self.yx_placeholderView;
}

@end


@implementation UITableView (TXPlaceholder)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self yx_exchangeOriginalMethod:@selector(reloadData) otherMethod:@selector(yx_reloadData)];
    });
}

- (void)yx_reloadData
{
    [self yx_reloadData];
    [self yx_matchingDataWithPlaceholderView];
}

- (void)yx_matchingDataWithPlaceholderView
{
    if (!self.yx_placeholderView) return;
    
    BOOL isClear = YES;
    NSInteger sections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [self.dataSource numberOfSectionsInTableView:self];
    }
    for (NSInteger i = 0; i < sections; i++) {
        if ([self.dataSource tableView:self numberOfRowsInSection:i]) {
            isClear = NO;
            break;
        }
    }
    self.yx_placeholderView.placeHolderType = isClear ? YXPlaceHolderCompare : YXPlaceholderViewModeDefault;
}

@end

@implementation UICollectionView (TXPlaceholder)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self yx_exchangeOriginalMethod:@selector(reloadData) otherMethod:@selector(yx_reloadData)];
    });
}

- (void)yx_reloadData
{
    [self yx_reloadData];
    [self tx_matchingDataWithPlaceholderView];
}


- (void)tx_matchingDataWithPlaceholderView
{
    if (!self.yx_placeholderView) return;
    
    BOOL isClear = YES;
    NSInteger sections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [self.dataSource numberOfSectionsInCollectionView:self];
    }
    for (NSInteger i = 0; i < sections; i++) {
        if ([self.dataSource collectionView:self numberOfItemsInSection:i]) {
            isClear = NO;
            break;
        }
    }
    self.yx_placeholderView.placeHolderType = isClear ? YXPlaceHolderCompare : YXPlaceholderViewModeDefault;
}


@end

@implementation NSObject (TXProperty)
+ (void)yx_exchangeClassOriginalMethod:(SEL)originalSel otherMethod:(SEL)otherSel
{
    yx_swizzleClassSelector(self, originalSel,otherSel);
}


+ (void)yx_exchangeOriginalMethod:(SEL)originalSel otherMethod:(SEL)otherSel
{
    Method swizzledMethod = class_getInstanceMethod(self, otherSel);
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    yx_addMethod(self, originalSel, swizzledMethod) ? yx_replaceMethod(self, otherSel, originalMethod) : yx_swizzleSelector(self, originalSel,otherSel);
}

static inline void yx_swizzleClassSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getClassMethod(theClass, originalSelector);
    Method swizzledMethod = class_getClassMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

static inline BOOL yx_addMethod(Class theClass, SEL selector, Method method) {
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}

static inline void yx_replaceMethod(Class theClass, SEL swizzledSel, Method originalMethod)
{
    class_replaceMethod(theClass, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
}
static inline void yx_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}



@end

/*
 //    if ([self.superview isKindOfClass:[UIScrollView class]]) {
 //        UIScrollView *scrollView = (UIScrollView *)self.superview;
 //        CGRect frame = self.frame;
 //        frame.origin.y = scrollView.contentInset.top;
 //        self.frame = frame;
 //    }
 */





//
//  YXPlaceHolderView.h
//  MyTest
//
//  Created by yaozhengzheng on 2017/8/1.
//  Copyright © 2017年 yaozhengzheng. All rights reserved.
// 
#import <UIKit/UIKit.h>
/*** 控件返回值宏定义 **/
#define TXINSTANCE_TYPE_RETURN(Class) __kindof Class *
/*** 所有方法返回值的block宏定义 **/
#define TXINSTANCE_TYPE(NAME, Class,...) \
typedef TXINSTANCE_TYPE_RETURN(Class) (^NAME)(__VA_ARGS__);

TXINSTANCE_TYPE(UIViewFloatInstance, UIView, CGFloat)

typedef NS_ENUM(NSInteger , YXPlaceHolderType) {
    YXPlaceholderViewModeDefault = 10086,
    YXPlaceHolderNone,
    YXPlaceHolderNorecord,  // 没有记录
    YXPlaceHolderNetWorkError, /// 网络不好
    YXPlaceHolderLoadFiled,  ///数据加载失败
    YXPlaceHolderCompare, //加入对比
};

@interface YXPlaceholderView : UIView
/// placeHolderType 做标记，防止多次创建相同的placeHolder
@property (nonatomic, assign) YXPlaceHolderType placeHolderType;

@property (nonatomic, copy) NSString *placeHolderTitle;

/// 改属性用于设置控制器上 除了tableView外 还有其他控件的View
- (UIViewFloatInstance)ignoredScrollViewContentInsetTop;
/***  若有点击刷新需求,实现该block即可  **/

@property (nonatomic, copy) void(^update)(void);

/***  不需要默认状态图片,通过此方法更改对应状态的图片  **/
- (void)setImage:(UIImage *)image forMode:(YXPlaceHolderType)type;
/***  不需要默认状态文字,通过此方法更改对应状态的文字,可以传nil  **/
- (void)setExplain:(NSString *)explain forMode:(YXPlaceHolderType)type;
/***  子类实现更改默认图片布局  **/
- (CGRect)explainRectForContentRect:(CGRect)contentRect;
/***  子类实现更改默认文字布局  **/
- (CGRect)imageRectForContentRect:(CGRect)contentRect;
@end


@interface UIView (YXPlaceholder)

@property (nonatomic, strong) __kindof YXPlaceholderView *yx_placeholderView;
/***  某个视图需要占位图,直接调用该方法,就可完成默认配置  **/
- (YXPlaceholderView *)yx_insertPlaceholderView;
///***  默认设置情况网络错误调用  eg: [[self.view yx_insertPlaceholderView].superview yx_networkError];**/
- (YXPlaceholderView *)yx_networkError;
///***  正常获取数据,不是列表视图方便调用  **/
//- (void)yx_quiteNormal;

@end

@interface NSObject (YXProperty)

/*** 运行时更换对象方法 **/
+ (void)yx_exchangeOriginalMethod:(SEL)originalSel otherMethod:(SEL)otherSel;

/*** 运行时更换类方法 **/
+ (void)yx_exchangeClassOriginalMethod:(SEL)originalSel otherMethod:(SEL)otherSel;

@end














//
//  UIMacros.h
//  YXCarLoanP
//
//  Created by HuangYingjie on 15/11/3.
//  Copyright © 2015年 yixin. All rights reserved.
//

#ifndef UIMacros_h
#define UIMacros_h

#pragma mark ----- screen rect

#define SCREEN_BOUNDS                   [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH                    (SCREEN_BOUNDS.size.width)
#define SCREEN_HEIGHT                   (SCREEN_BOUNDS.size.height)
#define SCREEN_WITHOUT_STATUS_HEIGHT    (SCREEN_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height)

#pragma mark ----- font

#define fit_RoundF(value) (roundf(value*10)/10) //主要用于字体
//定义字体大小
#define font(s) [UIFont systemFontOfSize:fit_RoundF(s* SCREEN_WIDTH/375)]
//横屏时候的字体大小
#define fontH(s) [UIFont systemFontOfSize:fit_RoundF(s* SCREEN_HEIGHT/375)]

//粗体字体
#define BoldFont(s) [UIFont boldSystemFontOfSize:fit_RoundF(s* SCREEN_WIDTH/375)]

#pragma mark ----- navigationBar

#define kNavigationBarColor                    @"#d12f26"
#define kNavigationBarHeight                   64.0f
#define kTabBarHeight                          49.0f
#define kNavigationBarTitleColor               @"#48453C"
#define kNavigationBarTitleFontSize            18.0f
#define kNavigationItemSpacerWidth             -15.0f
#define kNavigationTextItemSpacerWidth         0.0f
#define kNavBtnRect                            CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)
#define kSubTabBarHeight                       54

#pragma mark ----- animation time

#define kAnimationDuration                     1.5f
#define kAnimationTransitionDuration           0.8f
#define kHudHideDelay                          1.5f

#pragma mark ----- load image

//定义UIImage对象
#define ImageFiled(_file_) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:_file_ ofType:nil]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

//设置Rect
#define Rect(x,y,w,h) CGRectMake(x, y, w, h)

//设置size
#define Size(w,h) CGSizeMake(w, h)

//设置point
#define Point(x,y) CGPointMake(x, y)

//通用设置
#pragma mark ----- sms time interval

#define Second_After  61

#pragma mark ----- view flexible size

#define kViewFlexibleLeftWidth 15

//引导页数量
#define Guide_Page   3

//列表页面，每页获取多少条数据
#define Per_Page_Num  10

//判断iPhone5，6
#define iPhone5      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


// 系统版本
#define SYS_VERSION     [[UIDevice currentDevice] systemVersion]
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define fit_RoundI(value) (floor(value))   //向下取整

#define fit_width(width)            fit_RoundI((width) / 375.0f * (SCREEN_WIDTH))
#define fit_height(width, heigth)   fit_RoundI((fit_width(width)) * (heigth) / (width))

#define RectMake(x,y,w,h) CGRectMake(fit_width(x),fit_height(SCREEN_WIDTH, y) ,fit_width(w) , fit_height(SCREEN_WIDTH,h))


#define IOS10_OR_LATER (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
#define IOS9_OR_LATER (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
#define IOS8_OR_LATER (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
#define IOS7_OR_LATER (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))

#define IOS8_OR_EARLIER (!IOS9_OR_LATER)
#define IOS7_OR_EARLIER (!IOS8_OR_LATER)

// 获取1像素值，用于画一像素线
#define OnePixelValue   1.0/[[UIScreen mainScreen] scale]

#endif /* UIMacros_h */

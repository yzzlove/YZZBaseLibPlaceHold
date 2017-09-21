//
//  ColorsMacros.h
//  YXAutoPrice
//
//  Created by qiao jungang on 2017/3/10.
//  Copyright © 2017年 yixin. All rights reserved.
//

#ifndef ColorsMacros_h
#define ColorsMacros_h


#pragma mark - UIColor宏定义
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)
#define UIColorFromRGBAndAlpha(rgbValue, alpha) UIColorFromRGBA(rgbValue, alpha)

/**
 * 红色主色调
 */
#define kMainRedColor  UIColorFromRGB(0xE9474D)

/**
 * 浅黑色
 */
#define Color33  UIColorFromRGB(0x333333)
/**
 * 浅黑色
 */
#define Color66  UIColorFromRGB(0x666666)

/**
 *  灰色
 */
#define Color68  UIColorFromRGB(0x686868)
/**
 * 深黑色，如导航栏标题颜色，列表主标题颜色
 */
#define kDarkBlackColor UIColorFromRGB(0x394043)

/**
 * 浅灰，如列表的副标题等
 */
#define kLightGrayColor  UIColorFromRGB(0x9C9FA1)

/**
 * 浅红  入贷款买车 顶部tip
 */
#define kTipRedColor UIColorFromRGB(0xfff4ea)

/**
 * 浅红 贷款买车 提示文字颜色
 */
#define kTipTitleColor UIColorFromRGB(0xff8c39)

/**
 * 浅灰色
 */
#define Color99  UIColorFromRGB(0x999999)
/**
 * 浅灰色
 */
#define Colordd  UIColorFromRGB(0xdddddd)
/**
 * 浅灰 如首页section header
 */
#define Colorf5 UIColorFromRGB(0xf5f5f5)
/**
 * 浅灰 第三方登录tip文案颜色
 */
#define Colord0 UIColorFromRGB(0xd0d0d0)
/**
 * 浅灰 提交按钮
 */
#define Colord6 UIColorFromRGB(0xd0d0d0)
/**
 * 列表右侧索引字体颜色
 */
#define kMjIndexColor UIColorFromRGB(0x5a67ae)

/**
 * 浅绿色，如贷款买车页礼字背景
 */
#define kLightGreenColor UIColorFromRGB(0x06C1AE)
/**
 * 浅蓝
 */
#define kLightBlueColor UIColorFromRGB(0x6C90CD)

/**
 *  clear color
 */
#define ClearColor [UIColor clearColor]
/**
 *  white color
 */
#define WhiteColor [UIColor whiteColor]
/**
 *  black color
 */
#define BlackColor [UIColor blackColor]
/**
 *  orange color
 */
#define OrangeColor [UIColor orangeColor]
/**
 *  red color
 */
#define RedColor    [UIColor redColor]
/**
 *  green color
 */
#define GreenColor  [UIColor greenColor]

/**
 *  返回一个RGBA格式的UIColor对象
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 * r g b都为同一个数值时的颜色
 */
#define RGBS(r) RGB(r, r, r)

/**
 *  返回一个RGB格式的UIColor对象
 */

#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

/**
 *  返回随机颜色
 */
#define kRandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#pragma mark - line color

/**
 * 分割线颜色
 */
#define kSeperateLine_Color UIColorFromRGB(0xe5e5e5)


#endif /* ColorsMacros_h */

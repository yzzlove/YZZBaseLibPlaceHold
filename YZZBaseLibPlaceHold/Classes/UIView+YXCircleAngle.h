//
//  UIView+YXCircleAngle.h
//  MyTest
//
//  Created by yaozhengzheng on 2017/8/1.
//  Copyright © 2017年 yaozhengzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YXCircleAngle)

/**
 高性能的UIView控件的圆角裁剪

 @param strokeColor 边框的颜色
 @param lineWidth 边框的宽度
 @param cornerRadius 边框的角度
 */
- (void)strokeViewWithStrokeColor:(UIColor *)strokeColor AndWithLineWidth:(CGFloat)lineWidth AndWithCornerRadius:(CGFloat)cornerRadius;
@end

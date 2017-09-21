//
//  UIView+YXCircleAngle.m
//  MyTest
//
//  Created by yaozhengzheng on 2017/8/1.
//  Copyright © 2017年 yaozhengzheng. All rights reserved.
//

#import "UIView+YXCircleAngle.h"

@implementation UIView (YXCircleAngle)
///设置View的圆角
- (void)strokeViewWithStrokeColor:(UIColor *)strokeColor AndWithLineWidth:(CGFloat)lineWidth AndWithCornerRadius:(CGFloat)cornerRadius
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    borderLayer.lineWidth = lineWidth;
    borderLayer.strokeColor = strokeColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:cornerRadius];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    [self.layer insertSublayer:borderLayer atIndex:0];
    [self.layer setMask:maskLayer];
}

@end

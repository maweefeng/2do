//
//  UIColor+randomColor.m
//  2do
//
//  Created by Weefeng Ma on 2017/11/23.
//  Copyright © 2017年 maweefeng. All rights reserved.
//

#import "UIColor+randomColor.h"

@implementation UIColor (randomColor)
+ (UIColor*)randomColor

{
    
    CGFloat hue = (arc4random() %256/256.0);
    
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
    
}

@end

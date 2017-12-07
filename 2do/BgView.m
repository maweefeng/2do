//
//  BgView.m
//  2do
//
//  Created by Weefeng Ma on 2017/11/24.
//  Copyright © 2017年 maweefeng. All rights reserved.
//

#import "BgView.h"
@interface BgView()
@property(nonatomic,strong)CAGradientLayer *gradient;

@end
@implementation BgView

-(CAGradientLayer *)gradient{
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
    }
    
    return _gradient;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    
}
-(void)layoutSubviews{
    
    self.gradient.frame = self.frame;
    self.gradient.colors = [NSArray arrayWithObjects:
                            (id)[UIColor colorWithRed:0 green:143/255.0 blue:234/255.0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithRed:0 green:173/255.0 blue:234/255.0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithRed:122/255.0 green:224/255.0 blue:234/255.0 alpha:1.0].CGColor, nil];
    [self.layer addSublayer:self.gradient];
}
-(void)drawRect:(CGRect)rect{
    
    
}

@end

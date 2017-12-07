//
//  PresentCollectV.m
//  2do
//
//  Created by Weefeng Ma on 2017/11/23.
//  Copyright © 2017年 maweefeng. All rights reserved.
//

#import "PresentCollectV.h"
@interface PresentCollectV()


@end
@implementation PresentCollectV
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UISwipeGestureRecognizer * pan = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(removeIt)];
        [self addGestureRecognizer:pan];
        
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5, 10);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5;
        
        UILabel * taskName = [[UILabel alloc]init];
        taskName.text = @"Today is a good day";
        taskName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:taskName];
        [taskName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(20);
            make.width.equalTo(self).multipliedBy(0.5);
            make.height.mas_equalTo(30);
        }];
        UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancleBtn = cancleBtn;
        [cancleBtn setTitle:@"close" forState:UIControlStateNormal];
        [self.contentView addSubview:cancleBtn];
//        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).offset(20);
//            make.right.equalTo(self).offset(-20);
//            make.width.mas_equalTo(30);
//            make.height.mas_equalTo(30);
//
//        }];
        
        UILabel * time = [[UILabel alloc]init];
        time.text = @"10:20";
        time.textColor = [UIColor whiteColor];
        [self.contentView addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(taskName.mas_bottom).offset(20);
            make.left.equalTo(self).offset(20);
            make.width.equalTo(self);
            make.height.mas_equalTo(30);
        }];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

-(void)removeIt{
    if (self.frame.size.height>=ScreenH) {
        self.upBlock();
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect newRect = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        if (newRect.size.width == ScreenW) {
            //扩散到整个屏幕
            
        }
       
    }
    
    
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.cancleBtn setFrame:CGRectMake(rect.size.width-50, 20, 30, 30)];

}

@end

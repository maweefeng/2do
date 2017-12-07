//
//  PresentCollectV.h
//  2do
//
//  Created by Weefeng Ma on 2017/11/23.
//  Copyright © 2017年 maweefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentCollectV : UICollectionViewCell
@property(nonatomic,strong)UIButton * cancleBtn;
@property (nonatomic, copy) void (^upBlock)(void);
@end

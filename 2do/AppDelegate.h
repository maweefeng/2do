//
//  AppDelegate.h
//  2do
//
//  Created by Weefeng Ma on 2017/11/23.
//  Copyright © 2017年 maweefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


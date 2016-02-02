//
//  BaseViewController.h
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface BaseViewController : UIViewController
@property (nonatomic, strong) MenuViewController *menu;
@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, assign) BOOL isMenuOpen;
@property (nonatomic, assign) BOOL isJustBacomeActive;

-(void) openMenu;
-(void) closeMenu;


@end

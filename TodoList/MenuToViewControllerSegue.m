//
//  MenuToViewControllerSegue.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "MenuToViewControllerSegue.h"
#import "BaseViewController.h"
#import "MenuViewController.h"

@implementation MenuToViewControllerSegue

-(void)perform {
    MenuViewController *menuViewcontroller = self.sourceViewController;
    BaseViewController *baseViewController = (BaseViewController *)menuViewcontroller.parentViewController;
    
    UINavigationController *destinationVC = self.destinationViewController;
    
    if (!baseViewController.isJustBacomeActive) {
        CGRect openedFrame = baseViewController.navigationController.view.frame;
        [baseViewController.navigationController.view removeFromSuperview];
        baseViewController.navigationController.viewControllers = nil;
        baseViewController.navigationController = nil;
        
        baseViewController.navigationController = destinationVC;
        baseViewController.navigationController.view.frame = openedFrame;
        //navItem = destinationNVC.navigationBar.topItem;
        
        [baseViewController closeMenu];
        
       // [bottomVC.currentActiveNVC.view addGestureRecognizer:bottomVC.tapGesture];
        //[bottomVC.currentActiveNVC.view addGestureRecognizer:bottomVC.panGesture];
        
    }
    
    baseViewController.navigationController = destinationVC;
    UINavigationItem *navItem = baseViewController.navigationController.navigationBar.topItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 13);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    
    [button addTarget:baseViewController action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [baseViewController.view addSubview:destinationVC.view];
    [baseViewController addChildViewController:destinationVC];
    
    destinationVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    destinationVC.view.layer.shadowOpacity = 0.5;
    destinationVC.view.layer.shadowOffset = CGSizeMake(0, 0);
    destinationVC.view.layer.shadowRadius = 8;
    destinationVC.view.layer.masksToBounds = NO;
    destinationVC.view.layer.shadowPath =[UIBezierPath bezierPathWithRect:destinationVC.view.layer.bounds].CGPath;
    
    
    
}

@end

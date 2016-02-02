//
//  BaseToMenuSegue.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "BaseToMenuSegue.h"
#import "MenuViewController.h"
#import "BaseViewController.h"

@implementation BaseToMenuSegue

-(void)perform {
    BaseViewController *baseViewController = self.sourceViewController;
    MenuViewController *menuViewController = self.destinationViewController;
    [baseViewController.view addSubview:menuViewController.view];
    [baseViewController addChildViewController:menuViewController];
    [menuViewController didMoveToParentViewController:baseViewController];
    
    [menuViewController performSegueWithIdentifier:@"home" sender:self];
    
    
}
@end

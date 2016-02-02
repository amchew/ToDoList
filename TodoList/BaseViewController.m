//
//  BaseViewController.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "BaseViewController.h"

#define DEFAULT_WIDTH  250

@interface BaseViewController ()
-(void)initializeBaseViewController;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeBaseViewController];

}

-(void)initializeBaseViewController {
    self.isJustBacomeActive = YES;
    
    [self performSegueWithIdentifier:@"baseToMenu" sender:self];
    
    //self.tapGesture.enabled = NO;
    self.isMenuOpen = NO;
    self.isJustBacomeActive = NO;
    
}

-(void)openMenu {
    if (_isMenuOpen) {
        [self closeMenu];
    }else {
        CGRect frame = self.navigationController.view.frame;
        frame.origin.x = DEFAULT_WIDTH;
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.navigationController.view.frame = frame;
                             
                         }completion:^(BOOL finished){
                             
                         }];
        _isMenuOpen = YES;
    }
    
}

-(void)closeMenu {
    if (_isMenuOpen) {
        CGRect frame = self.navigationController.view.frame;
        frame.origin.x = 0;
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.navigationController.view.frame = frame;
                             
                         }completion:^(BOOL finished){
                             
                         }];
        _isMenuOpen = NO;
        
    }else {
        [self openMenu];
    }
    
}




@end

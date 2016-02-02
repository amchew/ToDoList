//
//  TutorialViewController.m
//  TodoList
//
//  Created by Kyaw Than Mong on 2/1/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray *pages;
-(void)exitFromtutorial;


@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pages = [TutorialPageModel allPages];

    TutorialStepViewController *stepVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialStep"];
    //stepVC.page = self.pages[0];
    
    [self setViewControllers:@[stepVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.dataSource = self;
    UIButton *addNewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    addNewButton.backgroundColor = [UIColor orangeColor];
    [addNewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addNewButton setTitle:@"skip to home" forState:UIControlStateNormal];
    [addNewButton.layer setCornerRadius:4];
    [addNewButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [addNewButton addTarget:self action:@selector(exitFromtutorial) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewButton];
    [addNewButton setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 40)];
    
    
}

-(void)exitFromtutorial {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    TutorialStepViewController *oldVC = (TutorialStepViewController *)viewController;
    int newIndex = oldVC.page.index + 1;
    if (newIndex > self.pages.count - 1) return nil;
    
    TutorialStepViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialStep"];
    newVC.page = self.pages[newIndex];
    return newVC;
    
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    TutorialStepViewController *oldVC = (TutorialStepViewController *)viewController;
    int newIndex = oldVC.page.index - 1;
    if (newIndex < 0) return nil;
    
    TutorialStepViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialStep"];
    newVC.page = self.pages[newIndex];
    return newVC;
    
}


@end


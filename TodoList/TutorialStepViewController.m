//
//  TutorialStepViewController.m
//  TodoList
//
//  Created by Kyaw Than Mong on 2/1/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "TutorialStepViewController.h"

@interface TutorialStepViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *previewIcon;
@property (weak, nonatomic) IBOutlet UILabel *tutorialTitle;
@property (weak, nonatomic) IBOutlet UILabel *tutorialSubtittle;
@property (weak, nonatomic) IBOutlet UILabel *initialInfo;

@end

@implementation TutorialStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initialInfo.hidden = YES;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.page == nil) {
        self.page = [TutorialPageModel allPages][0];
    }
    
    self.tutorialTitle.text = self.page.title;
    self.tutorialSubtittle.text = self.page.subtitle;
    if (self.page.index == 0) {
        self.initialInfo.hidden = NO;
    }else {
        self.initialInfo.hidden = YES;
    }
}

@end

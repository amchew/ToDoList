//
//  TutorialPageModel.m
//  TodoList
//
//  Created by Kyaw Than Mong on 2/2/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "TutorialPageModel.h"

@implementation TutorialPageModel

+(NSArray *)allPages {
    
    TutorialPageModel *page0 = [[TutorialPageModel alloc]initWithIndex:0 title:@"To Do App" subtitle:@"Add, Edit ,and Save your To Do List"];
    TutorialPageModel *page1 = [[TutorialPageModel alloc]initWithIndex:1 title:@"Add or Edit" subtitle:@"To Add or Edit , click on add bottom to new or edit bottom to edit exiting task"];

    TutorialPageModel *page2 = [[TutorialPageModel alloc]initWithIndex:2 title:@"Read or Write to Xml" subtitle:@"To save data ,click on save toolbar button or App will autometically save your save on you exit from the app"];

    TutorialPageModel *page3 = [[TutorialPageModel alloc]initWithIndex:3 title:@"Organize Tasks" subtitle:@"Tasks can be organized into categories or complete or pending order"];

    TutorialPageModel *page4 = [[TutorialPageModel alloc]initWithIndex:4 title:@"Remove / Complete " subtitle:@"Task can be marked as complete or remove"];
    return @[page0, page1, page2, page3, page4];

    
    
    
}
- (UIImage *)iconImage {
    return [UIImage imageNamed:[NSString stringWithFormat:@"icon_%d", self.index + 1]];
}

-(instancetype)initWithIndex:(int)index title:(NSString *)title subtitle:(NSString *)subtitle {
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _index = index;
        
    }
    return self;
}
@end

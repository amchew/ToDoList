//
//  ToDoCategoryViewController.h
//  TodoList
//
//  Created by Kyaw Than Mong on 2/1/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToItemCategoryDelegate <NSObject>
-(void)selectedCategory:(NSString*)categorytitle;

@end

@interface ToDoCategoryViewController : UIViewController
@property (nonatomic, strong) NSMutableSet* categoryList;
@property(weak, nonatomic) id<ToItemCategoryDelegate> delegate;

@end

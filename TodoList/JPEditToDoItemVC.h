//
//  JPEditToDoItemVC.h
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@protocol EditToDoItemDelegate <NSObject>

-(void)didEditItem :(ToDoItem *)item :(int)index;
-(void)didAddNewItem : (ToDoItem *) item;

@end

@interface JPEditToDoItemVC : UIViewController
@property (nonatomic, assign) BOOL isNewItem;
@property (nonatomic, nullable) ToDoItem *item;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) NSString *currentCategory;
@property (weak, nonatomic) id<EditToDoItemDelegate> delegate;
@property (strong, nonatomic) NSMutableSet *categorieList;



@end

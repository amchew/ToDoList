//
//  ToDoItem.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "ToDoItem.h"

@interface ToDoItem()

@end

@implementation ToDoItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        // default value
        _listTitle = @"Personal";
        _priority = NONE;
        _reminderDate = nil;
        _isComplete = NO;
    
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title  {
    self = [self init];
    if (self) {
        _itemTitle = title;
        
    }
    return  self;
}

-(instancetype)initWithTitle:(NSString *)title :(TODOPriorty *)priority :(NSString *)listTitle :(NSDate *)reminderDate{
    self = [self init];
    if (self) {
        _listTitle = listTitle;
        _itemTitle = title;
        _priority = priority;
        _reminderDate = reminderDate;
        
    }
    return self;
}

@end

//
//  ToDoItem.h
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TODOPriorty) {
    NONE = 0,
    LOW,
    MEDIUM,
    HIGH
    
};


@interface ToDoItem : NSObject
@property (nonatomic, strong , nonnull) NSString *itemTitle;
@property (nonatomic, nullable) NSDate *reminderDate;
@property (nonatomic, assign) TODOPriorty priority;
@property (nonatomic, strong , nonnull) NSString *listTitle;
@property (nonatomic, assign) BOOL isComplete;

-(instancetype) initWithTitle : ( NSString * _Nonnull ) title ;
-(instancetype) initWithTitle : (NSString *) title : (TODOPriorty *) priority : (NSString *) listTitle : (NSDate *) reminderDate;



@end

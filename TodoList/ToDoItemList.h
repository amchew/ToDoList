//
//  ToDoItemList.h
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"

@interface ToDoItemList : NSObject
@property (nonatomic, strong) NSMutableArray *toDoItemList;


-(void)addItemWith:(ToDoItem*) item ;
-(void)removeItemAtIndex : (NSInteger) index;
-(NSInteger)getSize;
-(ToDoItem *) getItemAtIndex : (NSInteger) index;
-(void)readToDolistFromTextFile :(void (^)(BOOL isFinished, NSError *error)) completeHandler;
-(void)replaceObjectInToDoItemListAtIndex:(NSInteger)index withObject:(id)object;
-(NSMutableSet *) getCategoryList;
-(NSMutableArray *) sortingWithKey : (NSString *) key;
-(NSMutableArray *) filterWithKey : (NSString* ) key;




@end

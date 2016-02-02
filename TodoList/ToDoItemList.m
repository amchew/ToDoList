//
//  ToDoItemList.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "ToDoItemList.h"
#import "DataWriter.h"



@interface ToDoItemList()
-(void)saveData;
@end

@implementation ToDoItemList

- (instancetype)init
{
    self = [super init];
    if (self) {
        _toDoItemList = [[NSMutableArray alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveData) name:@"saveData" object:nil];
    }
    return self;
}

-(void)saveData {
    [[[DataWriter alloc]init] writeToDolistIntoXml:self.toDoItemList];
    
}

#pragma mark : remove item at index

-(void)removeItemAtIndex:(NSInteger)index {
    [self.toDoItemList removeObjectAtIndex:index];
}

#pragma mark : add item
- (void)addItemWith:(ToDoItem *)item {
    if (_toDoItemList == nil) {
        _toDoItemList = [[NSMutableArray alloc] init];
    }
    [self.toDoItemList insertObject:item atIndex:0];
}

#pragma mark : get size
-(NSInteger)getSize {
    
    return self.toDoItemList.count;
}

#pragma mark : filter

-(NSMutableArray *)filterWithKey:(NSString *)key {
    if ([key isEqualToString:@"complete"]) {
        NSPredicate *completePred = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            ToDoItem *item = (ToDoItem *)evaluatedObject;
            return item.isComplete;
        }];
        
        NSArray * filteredArray = [self.toDoItemList filteredArrayUsingPredicate:completePred];
        NSLog(@"HERE %@",filteredArray);
        
    }
    else if([key isEqualToString:@"pending"]) {
        NSPredicate *pending = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            ToDoItem *item = (ToDoItem *)evaluatedObject;
            return !item.isComplete;
        }];
        
        NSArray * filteredArray = [self.toDoItemList filteredArrayUsingPredicate:pending];
        NSLog(@"HERE %@",filteredArray);
        
    }
    return [[NSMutableArray alloc]init];
}

#pragma mark : get item at index
-(ToDoItem *)getItemAtIndex:(NSInteger)index {
    return [self.toDoItemList objectAtIndex:index];
}

-(NSMutableSet *)getCategoryList {
    
    NSMutableSet *result = [[NSMutableSet alloc]init];
    
    for (ToDoItem * item in self.toDoItemList) {
        NSLog(@"%@", item.listTitle);
        [result addObject:item.listTitle];
        
    }
    return result;
    
}


#pragma mark : read text into todolist

-(void)readToDolistFromTextFile:(void (^)(BOOL, NSError *))completeHandler {
    NSError *error;
    NSString *strFileContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                   pathForResource: @"sampleTodoList" ofType: @"txt"] encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {  //Handle error
        completeHandler(YES, error);
        
    }
    
    NSLog(@"File content : %@ ", strFileContent);
    NSArray *mystrign = [strFileContent componentsSeparatedByString:@"\n"];
    [mystrign enumerateObjectsUsingBlock:^(id obj , NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", (NSString*)obj);
        ToDoItem *item = [[[ToDoItem alloc]init]initWithTitle:(NSString *)obj];
        [self addItemWith:item];
    }];
    completeHandler(YES, error);
}

-(void)replaceObjectInToDoItemListAtIndex:(NSInteger)index withObject:(id)object {
    ToDoItem *replacingItem = (ToDoItem *) object;
    [self.toDoItemList replaceObjectAtIndex:index withObject:replacingItem];
}


#pragma mark: sorting

-(NSMutableArray *)sortingWithKey:(NSString *)key {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [_toDoItemList sortedArrayUsingDescriptors:sortDescriptors];
    NSMutableArray *sorted = [[NSMutableArray alloc] initWithArray:sortedArray];
    return sorted;
}
@end

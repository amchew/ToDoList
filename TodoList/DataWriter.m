//
//  DataWriter.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "DataWriter.h"
#import "ToDoItem.h"

@interface DataWriter()
-(NSString *)dateToString: (NSDate *) date;
-(NSString *)priorityToString :(TODOPriorty *) priority;
-(NSString *)isCompleteToString:(BOOL)isComplete;

@end


@implementation DataWriter

-(NSString *)isCompleteToString:(BOOL)isComplete {
    if (isComplete) {
        return @"YES";
    }else {
        return @"NO";
    }
    //return isComplete == YES ? @"YES" : @"NO";
   
}


-(NSString *)dateToString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
   
    NSString *dateInString = [dateFormatter stringFromDate:date];
    if (dateInString) {
        return dateInString;
    }
    return @"null";
}


-(NSString *)priorityToString:(TODOPriorty *)priority {
    if (priority == HIGH) {
        return @"High";
    }
    else if (priority == MEDIUM) {
        return @"Medium";
    }
    
    else if (priority == LOW) {
        return @"low";
    }
    else {
        return @"none";
    }
    
}



-(void)writeToDolistIntoXml:(NSMutableArray *)items{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDirectory =  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                        inDomains:NSUserDomainMask] lastObject];
    NSString *path = [documentDirectory.path
                      stringByAppendingPathComponent:@"toDolist.xml"];
    if (error) {
        NSLog(@"error -----> %@", [error description]);
        
        
    }
   // NSURL *saveFile = [documentDirectory URLByAppendingPathComponent:@"toDolist.xml"];
    
    XMLWriter *writer = [[XMLWriter alloc]init];
    [writer writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
    
    [writer writeStartElement:@"todo_list"];
    for (ToDoItem * item in items) {
        [writer writeStartElement:@"todo_item"];
            [writer writeStartElement:@"title"];
            [writer writeCharacters:item.itemTitle];
            [writer writeEndElement];
        
            [writer writeStartElement:@"list_title"];
            [writer writeCharacters:item.listTitle];
            [writer writeEndElement];
        
        [writer writeStartElement:@"priority"];
        [writer writeCharacters:[self priorityToString:item.priority]];
        [writer writeEndElement];
        
        [writer writeStartElement:@"reminder"];
        [writer writeCharacters:[self dateToString:item.reminderDate]];
        [writer writeEndElement];
        
        [writer writeStartElement:@"isComplete"];
        [writer writeCharacters:[self isCompleteToString:item.isComplete]];
        [writer writeEndElement];
        
        [writer writeEndElement];
        
       
        
        
        
    }
    [writer writeEndElement];
    [writer writeEndDocument];
    
    NSString *todoInXml = [writer toString];
    NSLog(@"%@", todoInXml);
    NSError *writeError;
    [todoInXml writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&writeError];
    //[todoInXml writeToURL:path atomically:YES encoding:NSUTF8StringEncoding error:&writeError];
    if (writeError) {
        NSLog(@"can not write with %@",[writeError description]);
    }
    
}


@end

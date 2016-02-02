//
//  XMLParser.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "XMLParser.h"
#import "ToDoItem.h"


@interface XMLParser() <NSXMLParserDelegate>
@property (strong, nonatomic) NSMutableArray *itemlist;
@property (strong, nonatomic) NSXMLParser *parser;
@property(strong, nonatomic) NSMutableString *xmlText;
@property (strong , nonatomic) ToDoItem *currentItem ;
-(BOOL)isCompleteFromString : (NSString *)isDone;
-(NSDate *)dateFromString: (NSString *)dateInString;
-(TODOPriorty *)priorityFromString : (NSString *) priorityInString;



@end
@implementation XMLParser


- (instancetype)init
{
    self = [super init];
    if (self) {
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"toDolist" ofType:@"xml"];
        NSError *error;

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"toDolist.xml"];
        self.xml = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"error with %@", error);
        }
    }
    return self;
}
-(NSDate *)dateFromString:(NSString *)dateInString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([dateInString isEqualToString:@"null"]) {
        return nil;
    }
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateFormatter];
    if (date) {
        return date;
    }
    return nil;
}

-(BOOL)isCompleteFromString:(NSString *)isDone {
    if ([isDone isEqualToString:@"NO"]) {
        return NO;
    }
    return YES;
}

-(TODOPriorty)priorityFromString:(NSString *)priorityInString {
    if ([priorityInString isEqualToString:@"High"]) {
        return HIGH;
    }
    else if ([priorityInString isEqualToString:@"Medium"]) {
        return MEDIUM;
    }
    
    else if ([priorityInString isEqualToString:@"low"]) {
        return LOW;
    }
    else {
        return NONE;
    }
}


-(NSMutableArray *)parse {
    if (self.xml) {
        self.itemlist = [[NSMutableArray alloc]init];

        self.parser = [[NSXMLParser alloc]initWithData:[self.xml dataUsingEncoding:NSUTF8StringEncoding]];
        self.parser.delegate = self;
        [self.parser parse];
        
    }
    
    return self.itemlist;
}


#pragma mark: xml parser delegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    self.xmlText = [[NSMutableString alloc]init];
    
    if ([elementName isEqualToString:@"todo_item"]) {
        // initialize
        self.currentItem = [[ToDoItem alloc]init];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"title"]) {
       
        [self.currentItem setItemTitle:[self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
    }
    
    if ([elementName isEqualToString:@"list_title"]) {
        [self.currentItem setListTitle:[self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
    }
    if ([elementName isEqualToString:@"reminder"]) {
        [self.currentItem setReminderDate:[self dateFromString:[self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
    }
    if ([elementName isEqualToString:@"priority"]) {
        [self.currentItem setPriority:[self priorityFromString:[self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
    }
    
    if ([elementName isEqualToString:@"isComplete"]) {
        [self.currentItem setIsComplete:[self isCompleteFromString:[self.xmlText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
    }
    
    if ([elementName isEqualToString:@"todo_item"]) {
        [self.itemlist addObject:self.currentItem];
        
    }
   
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.xmlText appendString:string];
}

@end

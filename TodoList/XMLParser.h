//
//  XMLParser.h
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject
@property (strong, nonatomic) NSString * xml;
-(NSMutableArray *) parse;

@end

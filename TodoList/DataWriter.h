//
//  DataWriter.h
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLWriter.h"

@interface DataWriter : NSObject
@property (nonatomic, strong) NSString *xml;
-(void)writeToDolistIntoXml: (NSMutableArray *) items;


@end

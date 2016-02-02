//
//  TutorialPageModel.h
//  TodoList
//
//  Created by Kyaw Than Mong on 2/2/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialPageModel : NSObject
@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *subtitle;


+(NSArray *)allPages;
- (UIImage *)iconImage;
- (instancetype)initWithIndex:(int)index title:(NSString *)title subtitle : (NSString *)subtitle;



@end

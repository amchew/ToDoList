//
//  UIUnderlineView.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "UIUnderlineView.h"

@interface UIUnderlineView()
-(void)drawUnderline;

@end

@implementation UIUnderlineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawUnderline];
        
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self drawUnderline];
        
    }
    return self;
}

-(void)drawUnderline {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    CALayer *upperBorder = [CALayer layer];
    upperBorder.backgroundColor = [[UIColor lightGrayColor] CGColor];
    upperBorder.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 0.5f);
    [self.layer addSublayer:upperBorder];
}
@end

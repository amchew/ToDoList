//
//  UITextFieldOneSizeBorder.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "UITextFieldOneSizeBorder.h"

@interface UITextFieldOneSizeBorder()
-(void)layoutOneSidedBorder;

@end

@implementation UITextFieldOneSizeBorder

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self layoutOneSidedBorder];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self layoutOneSidedBorder];
    }
    return self;
}

-(void)layoutOneSidedBorder {
    self.borderStyle = UITextBorderStyleNone;
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5f;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
}

@end

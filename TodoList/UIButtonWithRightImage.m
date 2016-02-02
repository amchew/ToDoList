//
//  UIButtonWithRightImage.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "UIButtonWithRightImage.h"

@implementation UIButtonWithRightImage

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //init
        [self layoutRightImageView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //init
        [self layoutRightImageView];
    }
    return self;
}

-(void)layoutRightImageView {
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0)];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];

    
    //[myButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];

//    self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    self.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
}
@end

//
//  UIBlurImageView.m
//  TodoList
//
//  Created by Kyaw Than Mong on 2/1/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "UIBlurImageView.h"

@interface UIBlurImageView()
-(void)setupImageView;

@end

@implementation UIBlurImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImageView];
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupImageView];
        
        
    }
    return self;
}

-(void)setupImageView {
    self.translatesAutoresizingMaskIntoConstraints = NO;

    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // create vibrancy effect
    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
    
    // add blur to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.frame;
    UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
    vibrantView.frame = self.frame;
    
    // add both effect views to the image view
    [self addSubview:effectView];
    [self addSubview:vibrantView];
    
}

@end

/*
 self.imageView.image = [UIImage imageNamed:@"boat6"];
 
 // create blur effect
 UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
 
 // create vibrancy effect
 UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
 
 // add blur to an effect view
 UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
 effectView.frame = self.view.frame;
 
 // add vibrancy to yet another effect view
 UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
 vibrantView.frame = self.view.frame;
 
 // add both effect views to the image view
 [self.imageView addSubview:effectView];
 [self.imageView addSubview:vibrantView];
*/
//
//  JPToItemTCell.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "JPToItemTCell.h"

@implementation JPToItemTCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)didClickOnEdit:(id)sender {
    [self.delegate didClickOnActionWith:EDIT :self.index];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

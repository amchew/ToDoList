//
//  ToDoCategoryCell.h
//  TodoList
//
//  Created by Kyaw Than Mong on 2/1/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoCategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@end

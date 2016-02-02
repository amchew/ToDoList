//
//  JPToItemTCell.h
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ToItemActionType) {
    EDIT,
    SHARE
};

@protocol JPToItemDelegate <NSObject>
-(void) didClickOnActionWith : (ToItemActionType) actionType:(NSInteger) index;


@end

@interface JPToItemTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *toDoTitle;
@property (weak, nonatomic) IBOutlet UILabel *catagorieTitle;
@property (nonatomic, assign) NSInteger index;

@property (weak, nonatomic) id<JPToItemDelegate> delegate;


@end

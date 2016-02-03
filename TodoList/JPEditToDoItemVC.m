//
//  JPEditToDoItemVC.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "JPEditToDoItemVC.h"
#import "UITextFieldOneSizeBorder.h"
#import "JPToItemTCell.h"
#import "ToDoCategoryViewController.h"
#import "UIUnderlineView.h"



@interface JPEditToDoItemVC () <UITextFieldDelegate, ToItemCategoryDelegate>
@property (weak, nonatomic) IBOutlet UITextFieldOneSizeBorder *toDoItemTitle;
@property (weak, nonatomic) IBOutlet UISwitch *reminderSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *listTitle;
@property (weak, nonatomic) IBOutlet UILabel *reminderDate;
@property (weak, nonatomic) IBOutlet UIUnderlineView *reminderViewContainer;


@end

@implementation JPEditToDoItemVC
- (IBAction)didChangeReminder:(UISwitch *)sender {
    if (sender.on) {
        self.reminderDate.hidden = NO;
    }else {
        self.reminderDate.hidden = YES;
    }
}

- (IBAction)didSelectPriority:(id)sender {
}
- (IBAction)didClickOnList:(id)sender {
}



- (IBAction)didClickOnDone:(id)sender {
    NSString *title = self.toDoItemTitle.text;
    TODOPriorty priority = NONE;

    NSString *listTitle = self.listTitle.text;
    NSDate *reminder = nil;
    
    if (self.reminderSwitch.on) {
        reminder = [[NSDate alloc]init];
        
    }else {
        reminder = nil;
        
    }
    
    ToDoItem *newItemToAdd = [[[ToDoItem alloc]init]initWithTitle:title :self.prioritySegmentedControl.selectedSegmentIndex :listTitle : reminder];
  
    
    [self dismissViewControllerAnimated:YES completion:^(){
        if (_isNewItem) {
            newItemToAdd.isComplete = _item.isComplete;
            [self.delegate didAddNewItem:newItemToAdd];
        }else {
            
            [self.delegate didEditItem:newItemToAdd :_index];
         
        }
        
    }];
    
    
    
}


-(void)viewDidLoad {
    [super viewDidLoad];
    [self.prioritySegmentedControl setSelectedSegmentIndex:2];
    self.toDoItemTitle.delegate = self;
    [self.toDoItemTitle becomeFirstResponder];
    
    self.reminderViewContainer.hidden = YES;
   
    if (_isNewItem) {
        self.reminderSwitch.on = NO;
        self.reminderDate.hidden = YES;
        self.listTitle.text = @"Personal";
        
        
    }else {
        NSLog(@"%@", _item.itemTitle);
        self.toDoItemTitle.text = _item.itemTitle;
        self.listTitle.text = _item.listTitle;
        self.prioritySegmentedControl.selectedSegmentIndex = _item.priority;
        if (_item.reminderDate) {
            self.reminderSwitch.on = YES;
        }else {
            self.reminderSwitch.on = NO;
            self.reminderDate.hidden = YES;
        }
    
        
        
       
    }
    
}


- (IBAction)didClickOnExit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text) {
        NSLog(@"%@", textField.text);
    
    }
    
}

#pragma mark : ToDoitem catagory delegate 
-(void)selectedCategory:(NSString *)categorytitle {
    NSLog(@"delegate call");
    self.listTitle.text = categorytitle;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toCategory"]) {
        ToDoCategoryViewController *presentingVC = segue.destinationViewController;
        presentingVC.categoryList = self.categorieList;
        presentingVC.delegate = self;
        
    }
}

@end

//
//  ToDoCategoryViewController.m
//  TodoList
//
//  Created by Kyaw Than Mong on 2/1/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "ToDoCategoryViewController.h"
#import "ToDoCategoryCell.h"



@interface ToDoCategoryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryListTableView;
@property(strong, nonatomic) NSArray *categoryCopy;
-(void)addNewItem;

@end

@implementation ToDoCategoryViewController
- (IBAction)didClickOnCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *addNewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    addNewButton.backgroundColor = [UIColor orangeColor];
    [addNewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addNewButton setTitle:@"+" forState:UIControlStateNormal];
    [addNewButton.layer setCornerRadius:32];
    [addNewButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [addNewButton addTarget:self action:@selector(addNewItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewButton];
    [addNewButton setCenter:CGPointMake(self.view.frame.size.width - 40, self.view.frame.size.height - 40)];
     
    
    self.categoryListTableView.delegate = self;
    self.categoryListTableView.dataSource = self;
    [self.categoryListTableView reloadData ];
    
    for (NSString *item in self.categoryList) {
        NSLog(@"%@", item);
    }
    
    self.categoryCopy = [self.categoryList allObjects];
    // Do any additional setup after loading the view.
}



-(void)addNewItem {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Add New Category"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              UITextField *itemName = alert.textFields.firstObject;
                                                              
                                                              [self.categoryList addObject:itemName.text];
                                                              self.categoryCopy = [self.categoryList allObjects];
                                                              
                                                              [self.categoryListTableView reloadData];
                                                              
                                                          }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"new category";
        NSLog(@"add new item");
        //[self.categoryList addObject:textField.text];
        
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark : tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCELL" forIndexPath:indexPath];
    cell.title.text = self.categoryCopy[indexPath.row];
    return  cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryCopy.count ;// self.categoryList.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:^ {
        [self.delegate selectedCategory:self.categoryCopy[indexPath.row]];

        
    }];

}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"heightlisht %ld", (long)indexPath.row);
}


@end

//
//  MenuViewController.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/31/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "AboutViewController.h"
#import "HomeVC.h"

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, assign) BOOL isPresentingAbout;
@property (nonatomic, assign) BOOL isPresentingTutorial;
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuItems = [[NSMutableArray alloc]initWithObjects:@"Home", @"FAQ/Tutorial", @"About", nil];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [self.menuTableView reloadData];
}

#pragma mark : UITableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell" forIndexPath:indexPath];
    cell.menuTitle.text = self.menuItems[indexPath.row];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            _isPresentingTutorial = NO;
            _isPresentingAbout = NO;
            [self performSegueWithIdentifier:@"home" sender:self];
        }
            break;
            case 1:
        {
            _isPresentingTutorial = YES;
            _isPresentingAbout = NO;
            [self performSegueWithIdentifier:@"home" sender:self];
        }
            break;
        case 2:
        {
            _isPresentingTutorial = NO;
            _isPresentingAbout = YES;
            [self performSegueWithIdentifier:@"home" sender:self];
        }
            break;
       
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuItems.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"home"]) {
        NSLog(@"heading toward home");
        UINavigationController *presentingNVC = segue.destinationViewController;
        HomeVC *presentingVC = [presentingNVC viewControllers][0];
        if (_isPresentingAbout) {
            presentingVC.isPresentTutoring = NO;
            presentingVC.isPresentingAbout = YES;
        }
        else if (_isPresentingTutorial){
            presentingVC.isPresentTutoring = YES;
            presentingVC.isPresentingAbout = NO;
            
        }
        
    }
}


@end

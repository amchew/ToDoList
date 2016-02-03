//
//  HomeVC.m
//  TodoList
//
//  Created by Kyaw Than Mong on 1/30/16.
//  Copyright © 2016 Kyaw Than Mong. All rights reserved.
//

#import "HomeVC.h"
#import "JPEditToDoItemVC.h"
#import "JPToItemTCell.h"
#import "ToDoItemList.h"
#import "DataWriter.h"
#import "XMLParser.h"
#import "AboutViewController.h"
#import "ToDoCategoryCellTableViewCell.h"



#define ToItemTCELL @"ToDoTCell"
#define ToItemCategoryCELL @"CategoryCell"

#define encodingKeySegmentIndex @"encodingKeySegmentIndex"



typedef NS_ENUM(NSInteger, TABLESTATE){
    ALL = 0,
    PENDING,
    COMPLETE,
    CATEGORY
};

@interface HomeVC () <UITableViewDelegate, UITableViewDataSource, JPToItemDelegate, EditToDoItemDelegate , UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *itemTableStateSegmentControl;

-(UIColor *)getPriorityColor: (TODOPriorty *) priority;
@property (strong , nonatomic) NSMutableSet *categoryList;

@property (strong, nonatomic) NSMutableArray *allToItemList;
@property (strong, nonatomic) NSMutableArray *pendingItemList;
@property (strong, nonatomic) NSMutableArray *completeItemList;
@property (strong, nonatomic) NSMutableArray *categorys;

@property (assign, nonatomic) TABLESTATE currentTableState;

@property (weak, nonatomic) IBOutlet UITableView *toDoListTableView;


@property (nonatomic, strong) ToDoItemList *currentToDoList;

-(void)setupLoadDataTextFileView;
-(void)readDataFromTextFile;

@end

@implementation HomeVC

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.restorationIdentifier = @"HOME";

    }
    return  self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.restorationIdentifier = @"HOME";
    }
    return  self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentToDoList = [[ToDoItemList alloc]init];
    self.categorys = [[NSMutableArray alloc]init];
    self.currentTableState = ALL;
    self.toDoListTableView.delegate = self;
    self.toDoListTableView.dataSource = self;
    self.toDoListTableView.estimatedRowHeight = 120;
    self.toDoListTableView.rowHeight = UITableViewAutomaticDimension;
    self.toDoListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.title = @"Home";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //[self setupLoadDataTextFileView];
    
    NSLog(@"%ld number items", (long)[self.currentToDoList getSize]);
    [self.toDoListTableView reloadData];
     XMLParser *toDolistParser = [[XMLParser alloc] init];
    [self.currentToDoList setToDoItemList:[toDolistParser parse]];
    
    [self.currentToDoList setToDoItemList:[self.currentToDoList sortingWithKey:@"priority"]];
    self.categoryList = [self.currentToDoList getCategoryList];
    self.allToItemList = self.currentToDoList.toDoItemList;
    self.completeItemList = [self.currentToDoList filterWithKey:@"complete"];
    self.pendingItemList = [self.currentToDoList filterWithKey:@"pending"];
    [self.categorys addObjectsFromArray:[self.categoryList allObjects]];
    
    NSLog(@"pending len %lu", (unsigned long)self.categorys.count);
   
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"view will appear called");
    if (_isPresentingAbout) {
        _isPresentingAbout = NO;
        [self performSegueWithIdentifier:@"about" sender:self];


    }
    
    else if (_isPresentTutoring){
        _isPresentTutoring = NO;
        
        [self performSegueWithIdentifier:@"tutorial" sender:self];
    }
    
    else {
        if ([self.currentToDoList getSize]<=0) {
            [self setupLoadDataTextFileView];
        }else {
            [[self.view viewWithTag:1001]removeFromSuperview];

        }
    }
    

   
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.restorationClass = [self class];
}
#pragma mark : view for empty table

-(void)setupLoadDataTextFileView {
    
    UIButton *addNewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 64)];
    addNewButton.backgroundColor = [UIColor orangeColor];
    //[addNewButton sizeToFit];

    [addNewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addNewButton setTitle:@"Read data From Text File" forState:UIControlStateNormal];
    [addNewButton.layer setCornerRadius:4];
    addNewButton.tag = 1001;
    [addNewButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [addNewButton addTarget:self action:@selector(readDataFromTextFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewButton];
    [addNewButton setCenter:self.view.center];
    
}
-(void)readDataFromTextFile {
    [[self.view viewWithTag:1001]removeFromSuperview];

        [self.currentToDoList readToDolistFromTextFile:^(BOOL isDone, NSError *err) {
            if (isDone) {
        
            }
            
            [self.currentToDoList setToDoItemList:[self.currentToDoList sortingWithKey:@"priority"]];
            self.categoryList = [self.currentToDoList getCategoryList];
            self.allToItemList = self.currentToDoList.toDoItemList;
            self.completeItemList = [self.currentToDoList filterWithKey:@"complete"];
            self.pendingItemList = [self.currentToDoList filterWithKey:@"pending"];
            [self.categorys addObjectsFromArray:[self.categoryList allObjects]];
            [self.toDoListTableView reloadData];
    
        }];
    
}
#pragma Mark : add new item

- (IBAction)didClickOnAdd:(id)sender {
    NSLog(@"did click on add");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JPEditToDoItemVC *presentingVC = [storyboard instantiateViewControllerWithIdentifier:@"EditTODO"];
    presentingVC.isNewItem = YES;
    presentingVC.delegate = self;
    presentingVC.categorieList = self.categoryList;
    //presentingVC.item = [self.currentToDoList getItemAtIndex:index];
    [self presentViewController:presentingVC animated:YES completion:nil];

}

#pragma Mark : Save All item into xml

- (IBAction)didClickOnSave:(id)sender {
    DataWriter *writer = [[DataWriter alloc]init];
    [writer writeToDolistIntoXml:self.currentToDoList.toDoItemList];
    
    
}

#pragma Mark : Tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentTableState == CATEGORY) {
        ToDoCategoryCellTableViewCell *categoryCEll = [tableView dequeueReusableCellWithIdentifier:ToItemCategoryCELL forIndexPath:indexPath];
        categoryCEll.categoryTitle.text = self.categorys[indexPath.row];
        return categoryCEll;
        
    }else {
        JPToItemTCell *cell = [tableView dequeueReusableCellWithIdentifier:ToItemTCELL forIndexPath:indexPath];
        
        ToDoItem *model = [self.currentToDoList getItemAtIndex: indexPath.row];
        
        switch (self.currentTableState) {
            case ALL: {
                model = [self.allToItemList objectAtIndex:indexPath.row];

            }
                break;
            case PENDING:{
                model = [self.pendingItemList objectAtIndex:indexPath.row];

            }
                break;
            case COMPLETE:{
                model = [self.completeItemList objectAtIndex:indexPath.row ];

            }
                break;
                
            default:
                break;
        }
        
        
        UIColor *color = [self getPriorityColor: model.priority];// select needed color
        NSString *string = model.itemTitle;
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : color };
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
        cell.toDoTitle.attributedText = attrStr;
        cell.catagorieTitle.text = model.listTitle;
        cell.delegate = self;
        cell.index =  indexPath.row;
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (_currentTableState) {
        case ALL:
        {
            return self.allToItemList.count;
        }
            break;
        case PENDING:
        {
            return  self.pendingItemList.count;
        }
            break;
        case COMPLETE:
        {
            return self.completeItemList.count;
        }
            break;
        case CATEGORY:
            return self.categoryList.count;
        default:
            return 0;
            
    }
    //return [self.currentToDoList getSize];
}


#pragma mark: priority color 
-(UIColor *)getPriorityColor:(TODOPriorty )priority {
    if (priority == HIGH) {
        return [UIColor redColor];
    }
    else if (priority == MEDIUM) {
        return  [UIColor orangeColor];
    }
    else if (priority == LOW) {
        NSLog(@"prioty low.....");
        return [UIColor blueColor];
    }
    else {
        return [UIColor grayColor];
    }
}

-(void)didClickOnActionWith:(ToItemActionType)actionType :(NSInteger)index {
    ToItemActionType type = actionType;
    switch (type) {
        case EDIT: {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            JPEditToDoItemVC *presentingVC = [storyboard instantiateViewControllerWithIdentifier:@"EditTODO"];
            presentingVC.isNewItem = NO;
            presentingVC.delegate = self;
            presentingVC.index = index;
            
            for (NSString *item in self.categoryList) {
                NSLog(@"%@", item);
            }
            presentingVC.categorieList = self.categoryList;
            presentingVC.item = [self.currentToDoList getItemAtIndex:index];
            [self presentViewController:presentingVC animated:YES completion:nil];
            
        }
            NSLog(@"did click on edit on %ld", (long)index);
            
        case SHARE:
            break;
            
        default:
            break;
    }
}

#pragma mark: Edit/Add Delegate

-(void)didAddNewItem:(ToDoItem *)item {
    NSLog(@"received call back to client");
    [self.currentToDoList addItemWith:item];
    [self.currentToDoList setToDoItemList:[self.currentToDoList sortingWithKey:@"priority"]];
    self.categoryList = [self.currentToDoList getCategoryList];
    self.allToItemList = self.currentToDoList.toDoItemList;
    self.completeItemList = [self.currentToDoList filterWithKey:@"complete"];
    self.pendingItemList = [self.currentToDoList filterWithKey:@"pending"];
    [self.categorys addObjectsFromArray:[self.categoryList allObjects]];
    NSLog(@"%@", self.categoryList);
    
    UIView *removeView;
    while((removeView = [self.view viewWithTag:1001]) != nil) {
        [removeView removeFromSuperview];
    }
    

    [self.toDoListTableView reloadData];
    
}

-(void)didEditItem:(ToDoItem *)item :(NSInteger)index {
    [self.currentToDoList replaceObjectInToDoItemListAtIndex:index withObject:item];
    [self.currentToDoList setToDoItemList:[self.currentToDoList sortingWithKey:@"priority"]];
    self.categoryList = [self.currentToDoList getCategoryList];
    self.allToItemList = self.currentToDoList.toDoItemList;
    self.completeItemList = [self.currentToDoList filterWithKey:@"complete"];
    self.pendingItemList = [self.currentToDoList filterWithKey:@"pending"];
    [self.categorys addObjectsFromArray:[self.categoryList allObjects]];
       NSLog(@"%@", self.categorys);

    [self.toDoListTableView reloadData];
    
}



- (IBAction)didClickOnReport:(id)sender {
    if (self.currentTableState != ALL) {
        return ;
    }
    NSIndexPath *selectedIndexPath = [self.toDoListTableView indexPathForSelectedRow];

    NSLog(@"selected index is %ld", selectedIndexPath.row);
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Remove "
                                                    otherButtonTitles:@"Mark as Complete", nil];
    
    [actionSheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
  
    NSLog(@"click on %ld", buttonIndex);
    NSIndexPath *selectedIndexPath = [self.toDoListTableView indexPathForSelectedRow];

    if (buttonIndex == 0) {
        [self.currentToDoList removeItemAtIndex:selectedIndexPath.row];
        [self.currentToDoList setToDoItemList:[self.currentToDoList sortingWithKey:@"priority"]];
        self.categoryList = [self.currentToDoList getCategoryList];
        self.allToItemList = self.currentToDoList.toDoItemList;
        self.completeItemList = [self.currentToDoList filterWithKey:@"complete"];
        self.pendingItemList = [self.currentToDoList filterWithKey:@"pending"];
        [self.categorys addObjectsFromArray:[self.categoryList allObjects]];
        [self.toDoListTableView reloadData];
    }else {
        ToDoItem *model = [self.currentToDoList getItemAtIndex: selectedIndexPath.row];
        [model setIsComplete:YES];
        [model setPriority:NONE];
        [self.completeItemList addObject:model];
        [self.currentToDoList replaceObjectInToDoItemListAtIndex:selectedIndexPath.row withObject:model];
        [self.currentToDoList setToDoItemList:[self.currentToDoList sortingWithKey:@"priority"]];
        [self.toDoListTableView reloadData];


    }
    
    
}
- (IBAction)didClickListingOption:(UISegmentedControl *)sender {
    
    NSLog(@"did click in %ld", (long)sender.selectedSegmentIndex);
    switch (sender.selectedSegmentIndex) {
        case 0: {
            self.currentTableState = ALL;
            [self.toDoListTableView reloadData];
            
        }
            break;
        case 1: {
            self.currentTableState = PENDING;
            [self.toDoListTableView reloadData];
        }
            break;
        case 2:
        {
            self.currentTableState = COMPLETE;
            [self.toDoListTableView reloadData];
        }
            break;
        case 3:
        {
            self.currentTableState = CATEGORY;
            [self.toDoListTableView reloadData];
        }
            break;
            
        default:
            break;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    DataWriter *writer = [[DataWriter alloc]init];
    [writer writeToDolistIntoXml:self.currentToDoList.toDoItemList];
    
}


#pragma mark : State encoding

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    if ([self isViewLoaded]) {
        [coder encodeInteger:_itemTableStateSegmentControl.selectedSegmentIndex forKey:encodingKeySegmentIndex];

        
    }
    //coder.encodeInteger(citySelectionControl.selectedSegmentIndex, forKey: encodingKeySegmentIndex)
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    NSLog(@"restoring ..........");
    if ([self isViewLoaded]) {
        if ([coder decodeObjectForKey:encodingKeySegmentIndex]) {
            self.itemTableStateSegmentControl.selectedSegmentIndex = [coder decodeObjectForKey:encodingKeySegmentIndex] ;
            
        }
        [self.toDoListTableView reloadData];
    }
  
}


@end

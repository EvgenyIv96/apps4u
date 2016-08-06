//
//  EIGroupListViewController.m
//  Apps4u
//
//  Created by Евгений Иванов on 05.08.16.
//  Copyright © 2016 Евгений Иванов. All rights reserved.
//

#import "EIGroupListViewController.h"
#import "EIStudentsViewController.h"
#import "EIProfileViewController.h"
#import "EIDataManager.h"
#import "EIGroup.h"
#import "EIStudent.h"

@interface EIGroupListViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* groups;
@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray* dataArray;

@end

@implementation EIGroupListViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    [self configureButtons];
    [self configureSearchBar];
    [self configureTableView];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self pushProfileControllerForStudent:[self.dataArray objectAtIndex:indexPath.row]];
    
}

#pragma mark - Table view cell

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    EIStudent* student = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.4f animations:^{
        self.tableView.alpha = 0.75f;
    }];
    
    [self updateDataWithFilterString:searchBar.text];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [UIView animateWithDuration:0.4f animations:^{
        self.tableView.alpha = 0.75f;
    }];
    
    [self updateDataWithFilterString:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.4f animations:^{
        self.tableView.alpha = 0.f;
    }];
    
    searchBar.text = @"";
    [self updateDataWithFilterString:@""];
    [searchBar resignFirstResponder];
    
}

#pragma mark - Actions

- (void)groupButtonAction:(id)sender {
    
    if([sender isKindOfClass:[UIButton class]]) {
        
        UIButton* button = (UIButton *)sender;
        
        EIStudentsViewController* vc = [[EIStudentsViewController alloc] init];
        vc.group = [self.groups objectAtIndex:button.tag];
        
        [self. navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Data managment

- (void)getData {
    
    self.groups = [[EIDataManager sharedManager] getGroupsArray];
    
    if ([self.groups count] == 0) {
        [[EIDataManager sharedManager] generateGroupsWithStudents];
        [self getData];
    }
    
}

- (void)updateDataWithFilterString:(NSString *)filterString {
    
    self.dataArray = (NSArray *)[[EIDataManager sharedManager] getStudentsWithFilterString:filterString];
    [self.tableView reloadData];
    
}


#pragma mark - Other


- (void)configureNavigationBar {
    
    self.navigationItem.title = @"Groups";
    
}

- (void)configureSearchBar {
    
    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame) + 20, self.view.bounds.size.width, 44)];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:searchBar];
}

- (void)configureButtons {
    
    CGFloat y = CGRectGetMidY(self.view.bounds) - 30;
    CGFloat x = CGRectGetMidX(self.view.bounds) * 0.8;
    
    for (int i = 0; i < [self.groups count]; i++) {
        
        EIGroup* group = [self.groups objectAtIndex:i];
        
        NSString* buttonTitle = group.name;
        
        CGSize buttonStringSize = [buttonTitle sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0]}];
        
        UIButton* groupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [groupButton addTarget:self action:@selector(groupButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        groupButton.frame = CGRectMake(x, y, buttonStringSize.width + 5, buttonStringSize.height + 5);
        [groupButton setTitle:buttonTitle forState:UIControlStateNormal];
        [groupButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        groupButton.tag = i;
        groupButton.frame = CGRectIntegral(groupButton.frame);
        
        y += 40;
        
        groupButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [self.view addSubview:groupButton];
    }

}

- (void)configureTableView {
    
    CGFloat y = CGRectGetHeight(self.navigationController.navigationBar.frame) + [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - y) style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    tableView.alpha = 0.f;
    
    self.tableView = tableView;
    
}

- (void)pushProfileControllerForStudent:(EIStudent *)student {
    
    EIProfileViewController* vc = [[EIProfileViewController alloc] init];
    vc.student = student;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

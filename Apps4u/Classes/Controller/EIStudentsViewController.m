//
//  EIStudentsViewController.m
//  Apps4u
//
//  Created by Евгений Иванов on 05.08.16.
//  Copyright © 2016 Евгений Иванов. All rights reserved.
//

#import "EIStudentsViewController.h"
#import "EIStudent.h"
#import "EIGroup.h"
#import "EIDataManager.h"
#import "EIProfileViewController.h"

@interface EIStudentsViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSArray* dataArray;

@end

@implementation EIStudentsViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self updateDataWithFilterString:nil];
    [self configureNavigationBar];
    [self configureSearchBar];
    
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

#pragma mark - Data managment

- (void)updateDataWithFilterString:(NSString *)filterString {
    self.dataArray = (NSArray *)[[EIDataManager sharedManager] getStudentsForGroup:self.group withFilterString:filterString];
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateDataWithFilterString:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    [self updateDataWithFilterString:@""];
    [searchBar resignFirstResponder];
    
}

#pragma mark - Other

- (void)configureNavigationBar {
    self.navigationItem.title = self.group.name;
}

- (void)configureSearchBar {
    
    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;

    self.tableView.tableHeaderView = searchBar;

}

- (void)pushProfileControllerForStudent:(EIStudent *)student {
    
    EIProfileViewController* vc = [[EIProfileViewController alloc] init];
    vc.student = student;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

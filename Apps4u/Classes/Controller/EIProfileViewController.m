//
//  EIProfileViewController.m
//  Apps4u
//
//  Created by Евгений Иванов on 06.08.16.
//  Copyright © 2016 Евгений Иванов. All rights reserved.
//

#import "EIProfileViewController.h"
#import "EIStudent.h"

@implementation EIProfileViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureNavigationBar];
    [self configureView];
    
}

#pragma mark - Other

- (void)configureNavigationBar {
    self.navigationItem.title = @"User profile";
}

- (void)configureView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.jpg"]];
    
    image.frame = CGRectMake(CGRectGetMinX(self.view.bounds) + 25, CGRectGetMinY(self.view.bounds) + 75, 65, 65);
    
    image.layer.borderWidth = 0;
    image.layer.borderColor = [UIColor lightGrayColor].CGColor;
    image.layer.cornerRadius = image.frame.size.width/2;
    image.clipsToBounds = YES;
    
    [self.view addSubview:image];
    NSString* nameString = [NSString stringWithFormat:@"%@ %@", self.student.firstName, self.student.lastName];
    
    CGSize nameStringSize = [nameString sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.f]}];
    
    CGFloat x = CGRectGetMaxX(image.frame) + 30;
    
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMinY(image.frame) + 5, CGRectGetWidth(self.view.bounds) - 25 - x, nameStringSize.height)];
    [nameLabel setText:nameString];
    
    [self.view addSubview:nameLabel];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.YYYY"];
    
    NSString* birthDayString = [dateFormatter stringFromDate:self.student.dateOfBirth];

    CGSize birthDaySize = [birthDayString sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18.f]}];
    
    UILabel* birthDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(nameLabel.frame) + 10, CGRectGetWidth(self.view.bounds) - 25 - x, birthDaySize.height)];
    [birthDayLabel setText:birthDayString];
    
    [self.view addSubview:birthDayLabel];
    
}

@end

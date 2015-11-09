//
//  UniversityListViewController.m
//  GoToCollege
//
//  Created by Kavana Anand on 11/8/15.
//  Copyright © 2015 Kavana Anand. All rights reserved.
//

#import "UniversityListViewController.h"

@interface UniversityListViewController ()


@property (nonatomic,strong) UITableView *tableView;
@end

@implementation UniversityListViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view datasource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([[self tableArray] count] > 0)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[self tableArray] count]> 0)
    {
        return [[self tableArray] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary *dict = [[self tableArray] objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[dict valueForKey:@"univ_name"]];
    NSNumber *number = [dict valueForKey:@"tution_fees"];
    NSString *feeString = [number stringValue];
    NSNumber *livingExpenseNumber = [dict valueForKey:@"living_expenses"];
    NSString *leString = [livingExpenseNumber stringValue];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Fees:$%@    Living Expenses:$%@",feeString,leString]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

#pragma mark - view setup

-(void)setupView {
//    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
//    [bgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [[self view] addSubview:bgImageView];
//    [bgImageView setFrame:CGRectMake(0, 0, [[self view] bounds].size.width, [[self view] bounds].size.height)];
    
    [self setTableView:[[UITableView alloc] init]];
    [[self tableView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
//    [[self tableView] setBackgroundView:bgImageView];
    [[self view] addSubview:[self tableView]];
    
}

#pragma mark - AutoLayout methods

-(void)addConstraints {
    NSDictionary *viewsDictionary = @{@"tableView":[self tableView]};
    NSArray *constrainVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[tableView]|" options:0 metrics:nil views:viewsDictionary];
    NSArray *constrainHorizantal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:viewsDictionary];

    [[self view] addConstraints:constrainHorizantal];
    [[self view] addConstraints:constrainVertical];
}
                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                  
#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"Universities"];
    [self setupView];
    [self addConstraints];
}

@end

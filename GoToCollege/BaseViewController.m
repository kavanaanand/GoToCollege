//
//  BaseViewController.m
//  GoToCollege
//
//  Created by Kavana Anand on 11/7/15.
//  Copyright © 2015 Kavana Anand. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

-(void)displayAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *ac  = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [[self view] addSubview:[ac view]];
}

#pragma mark - View Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    [bgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self view] addSubview:bgImageView];
    [bgImageView setFrame:CGRectMake(0, 0, [[self view] bounds].size.width, [[self view] bounds].size.height)];
}




@end

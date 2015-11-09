//
//  UserInfoViewController.m
//  GoToCollege
//
//  Created by Kavana Anand on 11/7/15.
//  Copyright © 2015 Kavana Anand. All rights reserved.
//

#import "UserInfoViewController.h"
#import "MainViewController.h"
#import "UserObjet.h"
#import "Request.h"

@interface UserInfoViewController () <UITextFieldDelegate,F2CRequestProtocol>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *annualIncomeLabel;
@property (nonatomic, strong) UILabel *savingsLabel;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *annualIncomeTextField;
@property (nonatomic, strong) UITextField *savingsTextField;

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIButton *skipButton;

@property (assign,nonatomic) BOOL isSignUp;

//@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *email;
//@property (assign,nonatomic) NSString *incomeString;
//@property (assign,nonatomic) NSString *savingsString;
//@property (assign,nonatomic) NSNumber *income;
//@property (assign,nonatomic) NSNumber *savings;

@property (strong,nonatomic) UserObjet *userObj;

@property (nonatomic,strong) Request *requestManager;


@end

@implementation UserInfoViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"calculateSegue"]) {
        MainViewController *controller = [segue destinationViewController];
        [controller setIsSignUp:[self isSignUp]];
        [controller setEmailid:[self email]];
    }
}

- (void)createUserObject {
    UserObjet *userObject = [[UserObjet alloc] init];
    [userObject setUserName:[[self nameTextField] text]];
    [userObject setUserEmail:[[self emailTextField] text]];
    [userObject setUserIncome:[[self annualIncomeTextField] text]];
    [userObject setUserSavings:[[self savingsTextField] text]];
    [self setUserObj:userObject];
    [self loadUserDetails];
}

-(void)loadUserDetails {
    Request *request = [[Request alloc]init];
    [self setRequestManager:request];
    [[self requestManager] setF2cRequestDelegate:self];
    [[self requestManager] requestFeedFromServerFor:eUserLogin withDetails:[self userObj]];
}

-(void)pushNextScreen:(id)sender {
    [self performSegueWithIdentifier:@"calculateSegue" sender:self];
}

#pragma mark - Button Actions

-(void)submitButtonClicked:(id)sender {
    [self setIsSignUp:YES];
//    [self setName:[[self nameTextField] text]];
    [self setEmail:[[self emailTextField] text]];
//    [self setIncomeString:[[self annualIncomeTextField] text]];
//    [self setSavingsString:[[self savingsTextField] text]];
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [self setIncome:[formatter numberFromString:[[self annualIncomeTextField] text]]];
//    [self setSavings:[formatter numberFromString:[[self savingsTextField] text]]];
    
    [self createUserObject];
}

-(void)skipButtonClicked:(id)sender {
    [self setIsSignUp:NO];
    [self performSegueWithIdentifier:@"calculateSegue" sender:self];
}

#pragma mark - f2cRequestProtocol methods

-(void)didFinishResponse:(NSDictionary *)resultDict withType:(RequestType)reqType {
    NSLog(@"here!!!!");
    [self performSelectorOnMainThread:@selector(pushNextScreen:) withObject:nil waitUntilDone:NO];
}

-(void)didFailResponse:(NSString *)failResponse withType:(RequestType)reqType {
    NSLog(@"Error message:%@",failResponse);
}

#pragma mark - View setup

-(void)setupViews {
    [self setNameLabel:[[UILabel alloc] init]];
    [[self nameLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self nameLabel] setText:@"Name :"];
    [[self nameLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self nameLabel]];
    
    [self setEmailLabel:[[UILabel alloc] init]];
    [[self emailLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self emailLabel] setText:@"Email :"];
    [[self emailLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self emailLabel]];
    
    [self setAnnualIncomeLabel:[[UILabel alloc] init]];
    [[self annualIncomeLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self annualIncomeLabel] setText:@"Annual Income :"];
    [[self annualIncomeLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self annualIncomeLabel]];
    
    [self setSavingsLabel:[[UILabel alloc] init]];
    [[self savingsLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self savingsLabel] setText:@"Savings :"];
    [[self savingsLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self savingsLabel]];
    
    [self setNameTextField:[[UITextField alloc] init]];
    [[self nameTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self nameTextField] setPlaceholder:@"first+last name"];
    [[self nameTextField] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self nameTextField] setDelegate:self];
    [[self nameTextField] setKeyboardType:UIKeyboardTypeDefault];
    [[self view] addSubview:[self nameTextField]];
    
    [self setEmailTextField:[[UITextField alloc] init]];
    [[self emailTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self emailTextField] setPlaceholder:@"email"];
    [[self emailTextField] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self emailTextField] setDelegate:self];
    [[self emailTextField] setKeyboardType:UIKeyboardTypeEmailAddress];
    [[self view] addSubview:[self emailTextField]];

    [self setAnnualIncomeTextField:[[UITextField alloc] init]];
    [[self annualIncomeTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self annualIncomeTextField] setPlaceholder:@"0"];
    [[self annualIncomeTextField] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self annualIncomeTextField] setDelegate:self];
    [[self annualIncomeTextField] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[self view] addSubview:[self annualIncomeTextField]];
    
    [self setSavingsTextField:[[UITextField alloc] init]];
    [[self savingsTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self savingsTextField] setPlaceholder:@"0"];
    [[self savingsTextField] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self savingsTextField] setDelegate:self];
    [[self savingsTextField] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[self view] addSubview:[self savingsTextField]];
    
    
    [self setSubmitButton:[UIButton buttonWithType:UIButtonTypeSystem]];
    [[self submitButton] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self submitButton] setTitle:@"Sign Up" forState:UIControlStateNormal];
    [[self submitButton] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self submitButton] setClipsToBounds:YES];
    [[[self submitButton] layer] setCornerRadius:8.0f];
    [[[self submitButton] layer] setBorderWidth:1.0f];
    [[[self submitButton] layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self submitButton] addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self submitButton]];
    
    [self setSkipButton:[UIButton buttonWithType:UIButtonTypeSystem]];
    [[self skipButton] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self skipButton] setTitle:@"Skip" forState:UIControlStateNormal];
    [[self skipButton] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self skipButton] setClipsToBounds:YES];
    [[[self skipButton] layer] setCornerRadius:8.0f];
    [[[self skipButton] layer] setBorderWidth:1.0f];
    [[[self skipButton] layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self skipButton] addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self skipButton]];
}

#pragma mark - AutoLayout

-(void)addConstraints {
    NSDictionary *viewsDictionary = @{@"nameLabel":[self nameLabel],@"emailLabel":[self emailLabel],@"incomeLabel":[self annualIncomeLabel],@"savingsLabel":[self savingsLabel],@"nameTextField":[self nameTextField],@"emailTextField":[self emailTextField],@"incomeTextField":[self annualIncomeTextField],@"savingsTextField":[self savingsTextField], @"submit":[self submitButton],@"skip":[self skipButton]};
    
    NSArray *constraintHeight1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    NSArray *constraintHeight2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[emailLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    NSArray *constraintHeight3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[incomeLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    NSArray *constraintHeight4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[savingsLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    NSArray *constraintWidth1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[nameLabel(150)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    NSArray *constraintWidth2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[emailLabel(150)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    NSArray *constraintWidth3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[incomeLabel(150)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    NSArray *constraintWidth4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[savingsLabel(150)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    
    [[self nameLabel] addConstraints:constraintHeight1];
    [[self emailLabel] addConstraints:constraintHeight2];
    [[self annualIncomeLabel] addConstraints:constraintHeight3];
    [[self savingsLabel] addConstraints:constraintHeight4];
    [[self nameLabel] addConstraints:constraintWidth1];
    [[self emailLabel] addConstraints:constraintWidth2];
    [[self annualIncomeLabel] addConstraints:constraintWidth3];
    [[self savingsLabel] addConstraints:constraintWidth4];
    
    
    NSArray *constraintHeightTextField1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameTextField(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    NSArray *constraintHeightTextField2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[emailTextField(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    NSArray *constraintHeightTextField3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[incomeTextField(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    NSArray *constraintHeightTextField4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[savingsTextField(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    
    
    [[self nameTextField] addConstraints:constraintHeightTextField1];
    [[self emailTextField] addConstraints:constraintHeightTextField2];
    [[self annualIncomeTextField] addConstraints:constraintHeightTextField3];
    [[self savingsTextField] addConstraints:constraintHeightTextField4];

    
    
    NSArray *constraintHeightButton1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[submit(50)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    NSArray *constraintHeightButton2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[skip(50)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    [[self submitButton] addConstraints:constraintHeightButton1];
    [[self skipButton] addConstraints:constraintHeightButton2];
    
    
    NSArray *constrainVertical1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[nameLabel]-10-[emailLabel]-10-[incomeLabel]-[savingsLabel]-40-[submit]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    NSArray *constrainVertical2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[nameTextField]-30-[emailTextField]-30-[incomeTextField]-30-[savingsTextField]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
    
    NSArray *constraintHorizantal1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[nameLabel]-5-[nameTextField]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[emailLabel]-5-[emailTextField]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[incomeLabel]-5-[incomeTextField]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[savingsLabel]-5-[savingsTextField]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[submit]-5-[skip]-50-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];

    
    
    NSLayoutConstraint *equalWidthConstraint = [NSLayoutConstraint constraintWithItem:[self submitButton] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[self skipButton] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *alignTopConstraint = [NSLayoutConstraint constraintWithItem:[self submitButton] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[self skipButton] attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];

    [self.view addConstraints:constrainVertical1];
    [self.view addConstraints:constrainVertical2];
    [self.view addConstraints:constraintHorizantal1];
    [self.view addConstraints:constraintHorizantal2];
    [self.view addConstraints:constraintHorizantal3];
    [self.view addConstraints:constraintHorizantal4];
    [self.view addConstraints:constraintHorizantal5];
    [self.view addConstraint:equalWidthConstraint];
    [self.view addConstraint:alignTopConstraint];
    
}


#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"User Profile"];
    [self setupViews];
    [self addConstraints];
}

@end

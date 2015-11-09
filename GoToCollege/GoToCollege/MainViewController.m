//
//  MainViewController.m
//  GoToCollege
//
//  Created by Kavana Anand on 11/7/15.
//  Copyright © 2015 Kavana Anand. All rights reserved.
//

#import "MainViewController.h"
#import "CalculateDataObject.h"
#import "Request.h"
#import "UniversityListViewController.h"
#import "AllUniversityViewController.h"

@interface MainViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate,F2CRequestProtocol> {
    NSArray *yearPickerData;
}
@property (nonatomic, strong) UILabel *annualCostLabel;
@property (nonatomic, strong) UILabel *yearsLabel;
@property (nonatomic, strong) UILabel *majorLabel;
@property (nonatomic, strong) UILabel *emailLabel;


@property (nonatomic, strong) UITextField *annualCostTextField;
@property (nonatomic, strong) UILabel *yearsTextLabel;
@property (nonatomic, strong) UITextField *majorTextField;
@property (nonatomic, strong) UITextField *emailTextField;


@property (strong, nonatomic) UIPickerView *yearPickerView;
@property (assign, nonatomic) BOOL isYearPickerVisible;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) CalculateDataObject *calcObj;

@property (nonatomic, strong) Request *requestManager;

@property (nonatomic, strong) NSArray *resultArray;

@property (nonatomic, strong) UIButton *universityDetailsButton;
@property (nonatomic, strong) NSArray *universityArray;


@end

@implementation MainViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Picker View delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [yearPickerData count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return yearPickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%@",yearPickerData[row]);
    [[self yearsTextLabel] setText:yearPickerData[row]];
}

#pragma mark - private methods
-(void)getDetails:(UITapGestureRecognizer *)sender{
    
    UIViewController *pickerController = [[UIViewController alloc]init];
    [[self yearPickerView] setHidden:NO];
    [self setIsYearPickerVisible:YES];
    [pickerController setView:[self yearPickerView]];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
    if ([self isYearPickerVisible]) {
        [[self yearPickerView] setHidden:YES];
        [self setIsYearPickerVisible:NO];
    }
}

- (void)createCalculateObject {
    CalculateDataObject *calcObject = [[CalculateDataObject alloc] init];
    if ([self emailid] != NULL)
        [calcObject setUserEmail:[self emailid]];
    else
        [calcObject setUserEmail:[[self emailTextField] text]];
    [calcObject setUserTuitionCost:[[self annualCostTextField] text]];
    [calcObject setUserMajor:[[self majorTextField] text]];
    [calcObject setUserYears:[[self yearsTextLabel] text]];
    [self setCalcObj:calcObject];
    [self getResult];
}

-(void)getResult {
    Request *request = [[Request alloc]init];
    [self setRequestManager:request];
    [[self requestManager] setF2cRequestDelegate:self];
    [[self requestManager] requestResultsFromServerFor:eCalculate withDetails:[self calcObj]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"displaySegue"]) {
        UniversityListViewController *controller = [segue destinationViewController];
        [controller setTableArray:[self resultArray]];
    }
    if([segue.identifier isEqualToString:@"displayUniversitySegue"]) {
        AllUniversityViewController *controller1 = [segue destinationViewController];
        [controller1 setUniversityTableArray:[self universityArray]];
    }
}

-(void)pushTable:(id)sender {
    [self performSegueWithIdentifier:@"displaySegue" sender:self];
}

-(void)pushUniversityTable:(id)sender {
    [self performSegueWithIdentifier:@"displayUniversitySegue" sender:self];
}

#pragma mark - button actions

-(void)submitButtonClicked:(id)sender {

    [self createCalculateObject];
}

-(void)universityButtonClicked:(id)sender {
    
    Request *request = [[Request alloc]init];
    [self setRequestManager:request];
    [[self requestManager] setF2cRequestDelegate:self];
    [[self requestManager] requestResultsFromServerFor:eUniversity withDetails:nil];
}


#pragma mark - f2cRequestProtocol methods

-(void)didFinishUniversitiesResponse:(NSArray *)resultArray withType:(RequestType)reqType {
    NSLog(@"%@",resultArray);
    if (reqType == eCalculate) {
        [self setResultArray:resultArray];
        [self performSelectorOnMainThread:@selector(pushTable:) withObject:nil waitUntilDone:NO];
    } else if (reqType == eUniversity) {
        [self setUniversityArray:resultArray];
        [self performSelectorOnMainThread:@selector(pushUniversityTable:) withObject:nil waitUntilDone:NO];
    }
}

-(void)didFailResponse:(NSString *)failResponse withType:(RequestType)reqType {
    
}

#pragma mark - View setup
-(void)setupViews {
    [self setAnnualCostLabel:[[UILabel alloc] init]];
    [[self annualCostLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self annualCostLabel] setText:@"Annual College Cost :"];
    [[self annualCostLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self annualCostLabel]];
    
    [self setYearsLabel:[[UILabel alloc] init]];
    [[self yearsLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self yearsLabel] setText:@"No. of Years Enrolled :"];
    [[self yearsLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self yearsLabel]];
    
    [self setMajorLabel:[[UILabel alloc] init]];
    [[self majorLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self majorLabel] setText:@"Major :"];
    [[self majorLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self majorLabel]];
    
    [self setEmailLabel:[[UILabel alloc] init]];
    [[self emailLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self emailLabel] setText:@"Email :"];
    [[self emailLabel] setTextAlignment:NSTextAlignmentRight];
    [[self view] addSubview:[self emailLabel]];
    
    [self setAnnualCostTextField:[[UITextField alloc] init]];
    [[self annualCostTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self annualCostTextField] setPlaceholder:@"0"];
    [[self annualCostTextField] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self annualCostTextField] setDelegate:self];
    [[self annualCostTextField] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[self view] addSubview:[self annualCostTextField]];
    
    
    yearPickerData = @[@"1", @"2",@"3",@"4",@"5"];
    
    [self setYearPickerView:[[UIPickerView alloc] init]];
    [[self yearPickerView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self yearPickerView] setTag:1];
    [[self yearPickerView] setDataSource:self];
    [[self yearPickerView] setDelegate:self];
    [[self yearPickerView] setHidden:YES];
    [self setIsYearPickerVisible:NO];
    [[self view] addSubview:[self yearPickerView]];
    
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getDetails:)];
    [self setYearsTextLabel:[[UILabel alloc] init]];
    [[self yearsTextLabel] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self yearsTextLabel] setTag:1];
    [[self yearsTextLabel] setText:@"-"];
    [[self yearsTextLabel] setUserInteractionEnabled:YES];
    [[self yearsTextLabel] addGestureRecognizer:tapGesture1];
    [[self view] addSubview:[self yearsTextLabel]];
    
    [self setMajorTextField:[[UITextField alloc] init]];
    [[self majorTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self majorTextField] setPlaceholder:@"0"];
    [[self majorTextField] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self majorTextField] setDelegate:self];
    [[self majorTextField] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[self view] addSubview:[self majorTextField]];
    
    [self setEmailTextField:[[UITextField alloc] init]];
    [[self emailTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self emailTextField] setPlaceholder:@"email"];
    [[self emailTextField] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self emailTextField] setDelegate:self];
    [[self emailTextField] setKeyboardType:UIKeyboardTypeEmailAddress];
    [[self view] addSubview:[self emailTextField]];
    
    if ([self isSignUp] == YES) {
        [[self emailLabel] setHidden:YES];
        [[self emailTextField] setHidden:YES];
    }
    
    [self setSubmitButton:[UIButton buttonWithType:UIButtonTypeSystem]];
    [[self submitButton] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self submitButton] setTitle:@"Submit" forState:UIControlStateNormal];
    [[self submitButton] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self submitButton] setClipsToBounds:YES];
    [[[self submitButton] layer] setCornerRadius:8.0f];
    [[[self submitButton] layer] setBorderWidth:1.0f];
    [[[self submitButton] layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self submitButton] addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self submitButton]];
    
    [self setUniversityDetailsButton:[UIButton buttonWithType:UIButtonTypeSystem]];
    [[self universityDetailsButton] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self universityDetailsButton] setTitle:@"University Details" forState:UIControlStateNormal];
    [[self universityDetailsButton] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self universityDetailsButton] setClipsToBounds:YES];
    [[[self universityDetailsButton] layer] setCornerRadius:8.0f];
    [[[self universityDetailsButton] layer] setBorderWidth:1.0f];
    [[[self universityDetailsButton] layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self universityDetailsButton] addTarget:self action:@selector(universityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self universityDetailsButton]];
//    [[self universityDetailsButton] setHidden:YES];
    
}

#pragma mark - AutoLayout methods

-(void)addConstraints {
    NSDictionary *viewsDictionary = @{@"costLabel":[self annualCostLabel],@"yearsLabel":[self yearsLabel],@"majorLabel":[self majorLabel],@"emailLabel":[self emailLabel],@"costTextField":[self annualCostTextField],@"yearsTextLabel":[self yearsTextLabel],@"majorTextField":[self majorTextField],@"emailTextField":[self emailTextField],@"yearPickerView":[self yearPickerView],@"submit":[self submitButton],@"uniButton":[self universityDetailsButton]};
    
    NSArray *constraintHeight1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[costLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    NSArray *constraintHeight2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[yearsLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    NSArray *constraintHeight4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[majorLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    NSArray *constraintHeight3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[emailLabel(50)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    
    NSArray *constraintWidth1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[costLabel(170)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    NSArray *constraintWidth2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[yearsLabel(170)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    NSArray *constraintWidth4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[majorLabel(170)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    NSArray *constraintWidth3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[emailLabel(170)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    
    [[self annualCostLabel] addConstraints:constraintHeight1];
    [[self yearsLabel] addConstraints:constraintHeight2];
    [[self emailLabel] addConstraints:constraintHeight3];
    [[self majorLabel] addConstraints:constraintHeight4];
    [[self annualCostLabel] addConstraints:constraintWidth1];
    [[self yearsLabel] addConstraints:constraintWidth2];
    [[self emailLabel] addConstraints:constraintWidth3];
    [[self majorLabel] addConstraints:constraintWidth4];
    
    
    NSArray *constraintHeightTextField1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[costTextField(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    NSArray *constraintHeightTextField2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[yearsTextLabel(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    NSArray *constraintHeightTextField4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[majorTextField(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    NSArray *constraintHeightTextField3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[emailTextField(30)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    
    
    
    [[self annualCostTextField] addConstraints:constraintHeightTextField1];
    [[self yearsTextLabel] addConstraints:constraintHeightTextField2];
    [[self emailTextField] addConstraints:constraintHeightTextField3];
    [[self majorTextField] addConstraints:constraintHeightTextField4];

    
    NSArray *constraintHeightPickerView = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[yearPickerView(150)]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
    [[self yearPickerView] addConstraints:constraintHeightPickerView];
    
    
    NSArray *constraintHeightButton1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[submit(50)]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewsDictionary];
    [[self submitButton] addConstraints:constraintHeightButton1];
    
    NSArray *constraintHeightButton2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[uniButton(50)]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewsDictionary];
    [[self universityDetailsButton] addConstraints:constraintHeightButton2];
    
    
    NSArray *constrainVertical1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[costLabel]-10-[yearsLabel]-10-[majorLabel]-[emailLabel]-30-[submit]-30-[uniButton]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    NSArray *constrainVertical2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[costTextField]-30-[yearsTextLabel]-30-[majorTextField]-30-[emailTextField]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    NSArray *constrainVertical3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[yearPickerView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
    
    NSArray *constraintHorizantal1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[costLabel]-5-[costTextField]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[yearsLabel]-5-[yearsTextLabel]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[majorLabel]-5-[majorTextField]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[emailLabel]-5-[emailTextField]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[yearPickerView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[submit]-100-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    NSArray *constraintHorizantal7 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[uniButton]-100-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    
    [self.view addConstraints:constrainVertical1];
    [self.view addConstraints:constrainVertical2];
    [self.view addConstraints:constrainVertical3];
    [self.view addConstraints:constraintHorizantal1];
    [self.view addConstraints:constraintHorizantal2];
    [self.view addConstraints:constraintHorizantal3];
    [self.view addConstraints:constraintHorizantal4];
    [self.view addConstraints:constraintHorizantal5];
    [self.view addConstraints:constraintHorizantal6];
    [self.view addConstraints:constraintHorizantal7];

}

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"email: %@",[self emailid]);
    [self setTitle:@"Find"];
    [self setupViews];
    [self addConstraints];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}




@end

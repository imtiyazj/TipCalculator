//
//  ViewController.m
//  TipCalculator
//
//  Created by  Imtiyaz Jariwala on 1/13/17.
//  Copyright © 2017 yahoo. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTxtField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@end

@implementation TipViewController

NSUserDefaults *defaultSettings;
NSInteger defaultTip;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Tip Calculator";
    [self updateValues];
    
    defaultSettings = [NSUserDefaults standardUserDefaults];
    defaultTip = [defaultSettings integerForKey:@"default_tip_percentage"];
    [self.tipControl setSelectedSegmentIndex:defaultTip];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    
    defaultTip = [defaultSettings integerForKey:@"default_tip_percentage"];
    [self.tipControl setSelectedSegmentIndex:defaultTip];
    
    [self updateValues];
    
    NSLog(@"DEFAULT TIP: %li", (long)defaultTip);
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onValueChange:(UISegmentedControl *)sender {
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTxtField.text floatValue];
    
    NSArray *tipValues = @[@0.15, @0.2, @0.25];
    
    float tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;

    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

@end

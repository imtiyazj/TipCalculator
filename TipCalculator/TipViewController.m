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
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *otherTipPerc;
@property (weak, nonatomic) IBOutlet UILabel *otherTipPercLabel;

@end

@implementation TipViewController

NSArray *tipValues;
NSUserDefaults *defaultValues;
NSInteger defaultTip;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Tip Calculator";
    [self.otherTipPerc setHidden:YES];
    [self.otherTipPercLabel setHidden:YES];
    
    
    tipValues = @[@0.15, @0.2, @0.25];
    [self updateValues];
    
    defaultValues = [NSUserDefaults standardUserDefaults];
    defaultTip = [defaultValues integerForKey:@"default_tip_percentage"];
    [self.tipControl setSelectedSegmentIndex:defaultTip];
    
    
    [self.billTxtField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    defaultTip = [defaultValues integerForKey:@"default_tip_percentage"];
    [self.tipControl setSelectedSegmentIndex:defaultTip];
    
    [self updateValues];
    
    NSLog(@"DEFAULT TIP: %li", (long)defaultTip);
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
    float tipAmount;
    float billAmount = [self.billTxtField.text floatValue];
    int tipPerc;

    if (self.tipControl.selectedSegmentIndex == 3) {
        [self.otherTipPerc setHidden:NO];
        [self.otherTipPercLabel setHidden:NO];
        
        tipPerc = [self.otherTipPerc.text intValue];
        NSLog(@"TIP PERC: %@, %i", self.otherTipPerc.text, [self.otherTipPerc.text intValue]);
        tipAmount = (tipPerc / 100.00f) * billAmount;
    }
    else {
        [self.otherTipPerc setHidden:YES];
        [self.otherTipPercLabel setHidden:YES];
        
        tipPerc = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * 100;
        tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    }
    
    [self updateTipAmountLabel:tipPerc];
    
    float totalAmount = billAmount + tipAmount;
    NSLog(@"TIP AMT: %f", tipAmount);
    NSLog(@"TOTAL AMT: %f", totalAmount);
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
}

- (IBAction)onTipPercUpdate:(UITextField *)sender {
    [self updateValues];
}

- (void) updateTipAmountLabel:(int) tipPerc {
    self.tipAmountLabel.text = [NSString stringWithFormat:@"Tip Amount @ %i%%", tipPerc];
}

@end

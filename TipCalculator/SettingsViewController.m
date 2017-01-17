//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by  Imtiyaz Jariwala on 1/17/17.
//  Copyright © 2017 yahoo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *tipPercPicker;

@end

@implementation SettingsViewController

NSArray *pickerData;
NSInteger selectedRow;
NSUserDefaults *settings;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedRow = 0;
    pickerData = @[@"15%", @"20%", @"25%"];
    _tipPercPicker.delegate = self;
    _tipPercPicker.dataSource = self;
    _tipPercPicker.showsSelectionIndicator = YES;
    
    
    settings = [NSUserDefaults standardUserDefaults];
    selectedRow = [settings integerForKey:@"default_tip_percentage"];
    NSLog(@"SELECTED ROW: %li", selectedRow);
    
    [_tipPercPicker selectRow: selectedRow inComponent: 0 animated: YES];
    //[settings setValue: pickerData[0] forKey: @"default_tip_percentage"];
    //[settings synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveSettings:(UIButton *)sender {
    
    [settings setInteger: selectedRow forKey: @"default_tip_percentage"];
    [settings synchronize];
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    selectedRow = row;
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    //[self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

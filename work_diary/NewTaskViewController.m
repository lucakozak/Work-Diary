//
//  NewTaskViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
// "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";

#import "NewTaskViewController.h"

@interface NewTaskViewController () {
    NSArray *hours;
}

@property (weak, nonatomic) IBOutlet UITextField *tasknameField;
// @property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *workhourField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation NewTaskViewController

-(BOOL) validateHour:(NSString *)candidate {
    NSString *hourRegex = @"[0-9]{1,10}";
    NSPredicate *hourTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hourRegex];
    
    return [hourTest evaluateWithObject:candidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //  hours = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",];
    
   //  self.pickerView.dataSource = self;
   //  self.pickerView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/* -(NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView {
//     return 1;
// }

// -(NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return hours.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return hours[row];
}

-(void)pickerView: (UIPickerView *)pickerView didSelectRow:(NSInteger) inComponent:(NSInteger)component {
    self.label.text = hours[row];
}
*/


- (IBAction)savenewtask:(id)sender {
    
    if ([ _tasknameField.text isEqualToString:@""] ||
        [ _workhourField.text isEqualToString:@""] ||
        ![self validateHour:_workhourField.text])
        
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"OOops!" message:@"Something is wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else {
        [self saveNewTask];
    }
}
    
- (void) saveNewTask {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:_tasknameField.text forKey:@"taskname"];
        [defaults setObject:_workhourField.text forKey:@"workhour"];
        
        [defaults synchronize];
    
        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have added a new task, go back to home." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
       // [self performSegueWithIdentifier:@"backtohome" sender:self];
    
}
- (void) setLabel:(UILabel *)label
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *taskname = [defaults objectForKey:@"taskname"];
    
    _label = label;
    self.label.text = [NSString stringWithFormat:@" %@", taskname];
}




@end


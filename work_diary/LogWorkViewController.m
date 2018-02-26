//
//  LogWorkViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "LogWorkViewController.h"

@interface LogWorkViewController (){
    NSArray *tasks;
}
@property (weak, nonatomic) IBOutlet UITextField *workhourField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end

@implementation LogWorkViewController


-(BOOL) validateHour:(NSString *)candidate {
    NSString *hourRegex = @"[0-9]{1,10}";
    NSPredicate *hourTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hourRegex];
    
    return [hourTest evaluateWithObject:candidate];
}


- (void)viewDidLoad {
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
    tasks = [defaults objectForKey:@"taskname"];
      self.pickerView.dataSource = self;
      self.pickerView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView {
    return 1;
}
 
-(NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
 {
 return tasks.count;
 }
 
 -(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
 {
 return tasks[row];
 }

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    
    if(component == 0)
    {
        label.text = [tasks objectAtIndex:row];
    }

    return label;
}


- (IBAction)savelogwork:(id)sender {
    
    if ([ _workhourField.text isEqualToString:@""] ||
        ![self validateHour:_workhourField.text])
        
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"OOops!" message:@"Something is wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else { [self saveHour];
        
    }

}

- (void) saveHour {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray * hoursFromMemory = [defaults objectForKey:@"workhour"];
    NSMutableArray *hours;
    
    if (!hoursFromMemory) {
        hours= [[NSMutableArray alloc] init];
    }
    else {
        hours= [[NSMutableArray alloc] initWithArray:hoursFromMemory];
    }
    [hours addObject:self.workhourField.text];
    
    [defaults setObject:hours forKey:@"workhour"];
    
    [defaults synchronize];
    
    
    UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have added work hours to your task, go back to home." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [success show];

    
}

@end

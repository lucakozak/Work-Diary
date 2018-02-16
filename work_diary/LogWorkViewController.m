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
@property (weak, nonatomic) IBOutlet UIDatePicker *datepickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end

@implementation LogWorkViewController

- (void)viewDidLoad {
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
    tasks = @[@"",[defaults objectForKey:@"taskname"]];
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



@end

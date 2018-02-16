//
//  NewTaskViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
// "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";

#import "NewTaskViewController.h"

@interface NewTaskViewController () 

@property (weak, nonatomic) IBOutlet UITextField *tasknameField;
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


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
        NSArray * tasksFromMemory = [defaults objectForKey:@"taskname"];
    NSMutableArray *tasks;
        NSMutableArray * hours = [defaults objectForKey:@"workhour"];
    
    if (!tasksFromMemory) {
        tasks= [[NSMutableArray alloc] init];
    }
    else {
        tasks= [[NSMutableArray alloc] initWithArray:tasksFromMemory];
    }
    
        [tasks addObject:self.tasknameField.text];
        [tasks addObject:self.workhourField.text];
    
        [defaults setObject:tasks forKey:@"taskname"];
        [defaults setObject:hours forKey:@"workhour"];
        
        [defaults synchronize];
    
        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have added a new task, go back to home." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
        [success show];
    
}




@end


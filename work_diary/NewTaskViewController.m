//
//  NewTaskViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.


#import "NewTaskViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface NewTaskViewController () 

@property (weak, nonatomic) IBOutlet UITextField *tasknameField;
@property (weak, nonatomic) IBOutlet UITextField *estimatedhourField;

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
        [ _estimatedhourField.text isEqualToString:@""] ||
        ![self validateHour:_estimatedhourField.text])
        
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"OOops!" message:@"Something is wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else {
        [self saveNewTask];
        _tasknameField.text = nil;
        _estimatedhourField.text = nil;
    }
}

- (void) saveNewTask {
    
    NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    
    NSManagedObject *newActivation = [NSEntityDescription insertNewObjectForEntityForName:@"TaskDetails" inManagedObjectContext:context];
    
    [newActivation setValue:self.tasknameField.text forKey:@"taskname"];
    [newActivation setValue:[NSDecimalNumber decimalNumberWithString:self.estimatedhourField.text] forKey:@"estimatedhour"];
    
        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have added a new task, go back to home." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
        [success show];
    
}




@end


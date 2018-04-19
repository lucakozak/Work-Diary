//
//  ActivationViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "ActivationViewController.h"
#import <CoreData/CoreData.h>

#import "AppDelegate.h"




@interface ActivationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstnameField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordagainField;

@end

@implementation ActivationViewController

-(BOOL) validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}




- (void)viewDidLoad {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"registered"])
    {
        NSLog(@"No user is regsitered");
    }
    else
    {
        NSLog(@"User is registered");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)RegisterUser:(id)sender {
    if ([ _firstnameField.text isEqualToString:@""] ||
        [ _lastnameField.text isEqualToString:@""] ||
        [ _emailField.text isEqualToString:@""]    ||
        [ _passwordField.text isEqualToString:@""] ||
        [ _passwordagainField.text isEqualToString:@""]
        )
        
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Something is wrong!" message:@"You must complete all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else
    {
        [self checkPassword];
    }
}

- (void) checkPassword {
    if ([_passwordField.text isEqualToString:_passwordagainField.text])
    {
        NSLog(@"Passwords match");
        [self registerNewUser];
    }
    else
    {
        NSLog(@"passwords don't match");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Something is wrong!" message:@"Your entered passwords do not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
}

- (void) registerNewUser{
    NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;

    NSManagedObject *newActivation = [NSEntityDescription insertNewObjectForEntityForName:@"UserDetails" inManagedObjectContext:context];
    
    [newActivation setValue:self.emailField.text forKey:@"email"];
    [newActivation setValue: self.passwordField.text forKey:@"password"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else {
        
        NSLog(@"Data saved to CoreData");
        [self performSegueWithIdentifier:@"activate" sender:self];

    }
    
}

@end

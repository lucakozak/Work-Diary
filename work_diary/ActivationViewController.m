//
//  ActivationViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "ActivationViewController.h"

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
        //|| ![self validateEmail:[_emailField text]]
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
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:_emailField.text forKey:@"email"];
        [defaults setObject:_passwordField.text forKey:@"password"];
        [defaults setBool:YES forKey:@"registered"];
        
        [defaults synchronize];
        
        
        [self performSegueWithIdentifier:@"activate" sender:self];
        
        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have registered a new user" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [success show];
    }

@end

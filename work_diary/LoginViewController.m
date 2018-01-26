//
//  LoginViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([_emailField.text isEqualToString:[defaults objectForKey:@"email"]]
        && [_passwordField.text isEqualToString:[defaults objectForKey:@"password"]])
    {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    
    else
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Something is wrong!" message:@"Name or password is not correct!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [error show];
    }
    
}

- (IBAction)deactivate:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"registered"];
    
    [self performSegueWithIdentifier:@"deactivate" sender:self];
}

@end

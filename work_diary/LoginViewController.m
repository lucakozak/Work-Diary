//
//  LoginViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "LoginViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
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
    NSManagedObjectContext *moc = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserDetails"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (!results)
    {
        NSLog(@"Error fetching data. %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    if (results.count > 0) {
        
        NSManagedObject *person = (NSManagedObject *)[results objectAtIndex:0];
        NSString *email = [person valueForKey:@"email"];
        NSString *password = [person valueForKey:@"password"];
        if ([_emailField.text isEqualToString:email] && [_passwordField.text isEqualToString:password]) {
            [self performSegueWithIdentifier:@"login" sender:self];
        }
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

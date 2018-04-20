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
    
    NSManagedObjectContext *context =[AppDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *UserDetails = [NSEntityDescription entityForName:@"UserDetails" inManagedObjectContext:context];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID like %@",userID];
    [fetchRequest setEntity:UserDetails];
    //[fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [context deleteObject:managedObject];
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Car"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    
    /*NSFetchRequest *allCars = [[NSFetchRequest alloc] init];
    [allCars setEntity:[NSEntityDescription entityForName:@"UserDetails" inManagedObjectContext:context]];
    [allCars setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *cars = [context executeFetchRequest:allCars error:&error];
    [allCars release];
    //error handling goes here
    for (NSManagedObject *car in cars) {
        [context deleteObject:car];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    */

    [self performSegueWithIdentifier:@"deactivate" sender:self];
}

@end

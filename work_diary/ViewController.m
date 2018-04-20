//
//  ViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)start:(id)sender {
    

    NSManagedObjectContext *moc = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserDetails"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (!results)
    {
        NSLog(@"No user is regsitered");
        
        [self performSegueWithIdentifier:@"firstactivation" sender:self];

    }
    
    else /*(results.count > 0)*/ {
        
        NSLog(@"user is registered");
        
        [self performSegueWithIdentifier:@"activate" sender:self];
        }
    

}


@end

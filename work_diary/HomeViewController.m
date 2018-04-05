//
//  HomeViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)newtask:(id)sender {
    [self performSegueWithIdentifier:@"makenewtask" sender:self];
}

- (IBAction)logwork:(id)sender {
    [self performSegueWithIdentifier:@"logwork" sender:self];

}
- (IBAction)tasklist:(id)sender {
    [self performSegueWithIdentifier:@"viewtasklist" sender:self];

}

- (IBAction)history:(id)sender {
    [self performSegueWithIdentifier:@"viewhistory" sender:self];
    
}


@end

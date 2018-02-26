//
//  TaskDetailsViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 02. 22..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "TaskDetailsViewController.h"

@interface TaskDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tasknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimatedhoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *workinghoursLabel;

@end

@implementation TaskDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasknameLabel.text=self.name;
    self.estimatedhoursLabel.text=self.estimatedhour;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end

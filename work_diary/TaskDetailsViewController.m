//
//  TaskDetailsViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 02. 22..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface TaskDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tasknameField;
@property (weak, nonatomic) IBOutlet UILabel *estimatedhourField;
@property (weak, nonatomic) IBOutlet UILabel *workinghourField;
@property (weak, nonatomic) IBOutlet UILabel *conclusionLabel;

@end

@implementation TaskDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasknameField.text=self.name;
    self.estimatedhourField.text=self.estimatedhour;
    self.workinghourField.text=self.workhour;
    
    NSManagedObjectContext *moc = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TaskDetails"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    NSManagedObject *task = (NSManagedObject *)[results objectAtIndex:0];
    
    NSNumber *newhour = [NSNumber numberWithInt:[self.workinghourField.text intValue]];
    NSMutableDictionary * hoursDictionaryFromMemory = [task valueForKey:@"workhour"];
    NSNumber *oldhour = 0;

    
    
    
}

- (void) setConclusion:(UILabel *)conclusion
{
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end

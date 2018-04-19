//
//  LogWorkViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "LogWorkViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface LogWorkViewController (){
    //NSArray *taskname;
}
@property (weak, nonatomic) IBOutlet UITextField *workhourField;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *taskname;
@property (copy, nonatomic) NSArray *navigationParameters;
@property (nonatomic,strong) NSString *selectedRow;


@end

@implementation LogWorkViewController


-(BOOL) validateHour:(NSString *)candidate {
    NSString *hourRegex = @"[0-9]{1,10}";
    NSPredicate *hourTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hourRegex];
    
    return [hourTest evaluateWithObject:candidate];
}


- (void)viewDidLoad {
    NSManagedObjectContext *moc = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TaskDetails"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    self.taskname= [[NSMutableArray alloc] init];
    for (int i=0; i<results.count; i++) {
        NSManagedObject *task = (NSManagedObject *)[results objectAtIndex:i];
        NSString *taskname = [task valueForKey:@"taskname"];
        
        [self.taskname addObject:taskname];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_taskname.count >0 ) {
        return self.taskname.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.taskname[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    
    return cell;
}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==-1) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectedRow = self.taskname[indexPath.row];
    
}

- (IBAction)savelogwork:(id)sender {
    
    if ([ _workhourField.text isEqualToString:@""] ||
        ![self validateHour:_workhourField.text])
        
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"OOops!" message:@"Something is wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else { [self saveHour];
        _workhourField.text = nil;

    }

}

- (void) saveHour {
    NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    
    NSManagedObject *saveHour = [NSEntityDescription insertNewObjectForEntityForName:@"TaskDetails" inManagedObjectContext:context];
    
    [saveHour setValue:self.workhourField.text forKey:@"workhour"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    NSLog(@"Data saved to CoreData");
    [self performSegueWithIdentifier:@"activate" sender:self];
    
    
}

@end

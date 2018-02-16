//
//  HistoryViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 30..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController () {
    NSMutableArray *tasksToDelete;
    NSMutableArray *tasksData;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (copy, nonatomic) NSArray *tasks;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //tasksData = [[NSMutableArray alloc] init];
    //tasksToDelete = [[NSMutableArray alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.tasks = [defaults objectForKey:@"taskname"];
    [self.table beginUpdates];
    
    
    NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:_tasks.count-1 inSection:0]];
    [self.table insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.table endUpdates];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tasks.count >0 ) {
    return [self.tasks count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.tasks[indexPath.row];
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
    [tasksToDelete addObject: tasksData[indexPath.row]];
    
    NSString *rowValue = self.tasks[indexPath.row];
    
    NSString *message = [[NSString alloc]initWithFormat:@"You selected %@!",rowValue];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row selected" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tasksToDelete removeObject:tasksData[indexPath.row]];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}




@end

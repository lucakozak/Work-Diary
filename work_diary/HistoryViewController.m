//
//  HistoryViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 30..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "HistoryViewController.h"
#import "TaskDetailsViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) NSMutableArray *estimatedhour;
@property (copy, nonatomic) NSDictionary *workhour;
@property (copy, nonatomic) NSArray *navigationParameters;

@end

@implementation HistoryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.allowsMultipleSelectionDuringEditing = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.tasks = [NSMutableArray arrayWithArray:[defaults objectForKey:@"taskname"]];
    self.estimatedhour = [NSMutableArray arrayWithArray:[defaults objectForKey:@"estimatedhour"]];
    self.workhour = [defaults objectForKey:@"workhour"];
    }

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tasks.count > 0 ) {
    return self.tasks.count;
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
    
    NSString *rowValueOne = self.tasks[indexPath.row];
    NSString *rowValueTwo = self.estimatedhour[indexPath.row];
    NSNumber *rowValueThree = [self.workhour objectForKey:rowValueOne];
    
    NSString *messageOne = [[NSString alloc]initWithFormat:@"%@",rowValueOne];
    NSString *messageTwo = [[NSString alloc]initWithFormat:@"%@",rowValueTwo];
    NSString *messageThree = [[NSString alloc]initWithFormat:@"%@",rowValueThree];
    
    _navigationParameters =  [NSArray arrayWithObjects:messageOne, messageTwo, messageThree, nil];
    
    [self performSegueWithIdentifier:@"details" sender:self ];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.estimatedhour removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    {
       TaskDetailsViewController *vc = [segue destinationViewController];
        
        vc.name = _navigationParameters[0];
        vc.estimatedhour = _navigationParameters[1];
        vc.workhour = _navigationParameters[2];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}





@end

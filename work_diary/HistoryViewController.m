//
//  HistoryViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 30..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (copy, nonatomic) NSArray *tasks;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
    self.tasks = @[@"@",[defaults objectForKey:@"taskname"]];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *SimpleIdentifier = @"Simpleidentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    UIImage *image1 = [UIImage imageNamed:@"table.png"];
    cell.imageView.image = image1;
    
    cell.textLabel.text = self.tasks[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    
    if (indexPath.row < 2) {
        cell.detailTextLabel.text = @"First 2";
    } else {
        cell.detailTextLabel.text = @"Last 2";
    }
    
    return cell;
}

/*- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
 if (indexPath.row < 2) {
 return 0;
 } else {
 return 1;
 }
 }*/

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *rowValue = self.tasks[indexPath.row];
    NSString *message = [[NSString alloc]initWithFormat:@"You selected %@!",rowValue];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row selected" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}



@end
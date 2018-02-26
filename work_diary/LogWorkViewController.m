//
//  LogWorkViewController.m
//  work_diary
//
//  Created by Kozak, Luca on 2018. 01. 25..
//  Copyright © 2018. Kozak, Luca. All rights reserved.
//

#import "LogWorkViewController.h"

@interface LogWorkViewController (){
    NSArray *tasks;
}
@property (weak, nonatomic) IBOutlet UITextField *workhourField;
@property (weak, nonatomic) IBOutlet UITableView *table;
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
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
    tasks = [defaults objectForKey:@"taskname"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tasks.count >0 ) {
        return self->tasks.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self->tasks[indexPath.row];
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
    //_selectedRow = @indexPath.row;
    _selectedRow = self->tasks[indexPath.row];
    //NSString *rowValueOne = self->tasks[indexPath.row];
    
    //NSString *messageOne = [[NSString alloc]initWithFormat:@"%@",rowValueOne];
    
    //_navigationParameters =  [NSArray arrayWithObjects:messageOne,nil];
    
    
}

- (IBAction)savelogwork:(id)sender {
    
    if ([ _workhourField.text isEqualToString:@""] ||
        ![self validateHour:_workhourField.text])
        
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"OOops!" message:@"Something is wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else { [self saveHour];
        
    }

}

- (void) saveHour {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSArray * hoursFromMemory = [defaults objectForKey:@"workhour"];
    //NSMutableArray *hours;
    
    NSNumber *newhour = [NSNumber numberWithInt:[self.workhourField.text intValue]];
    NSMutableDictionary * hoursDictionaryFromMemory = [[defaults objectForKey:@"workhour"] mutableCopy];
    NSNumber *oldhour = 0;
    
    if (!hoursDictionaryFromMemory) {
        hoursDictionaryFromMemory = [[NSMutableDictionary alloc] init];
        //hours= [[NSMutableArray alloc] init];
        //[hoursDictionaryFromMemory setObject:hours forKey:_selectedRow];
    }
    else {
        oldhour = [hoursDictionaryFromMemory objectForKey:_selectedRow];
    }
    
    //NSNumber *hour = oldhour + newhour;
    NSNumber *hour = @([oldhour integerValue] + [newhour intValue]);
    
    [hoursDictionaryFromMemory removeObjectForKey:_selectedRow];
    [hoursDictionaryFromMemory setObject:hour forKey:_selectedRow];
    
    [defaults removeObjectForKey:@"workhour"];
    [defaults setObject:hoursDictionaryFromMemory forKey:@"workhour"];
    
    [defaults synchronize];
    
    
    UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have added work hours to your task, go back to home." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [success show];

    
}


@end

//
//  ViewController.m
//  ECHackDemoApp
//
//  Created by Pete Biencourt on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize calendarData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadCalendarData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onClockButtonPressed:(UIButton *)sender {

    if ([self.clockButton.currentTitle isEqualToString:@"Clock In"]){
        [self.clockButton setTitle:@"Clock Out" forState:UIControlStateNormal];
    }
    else{
        [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
    }
    

    //when stop button pressed
    //[self recordData:date hours:hours wage: wage]
    //[self saveCalendarData
}

- (void) loadCalendarData{
    //Find calendar data in plist file and load to calendar dictionary.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [directoryPaths objectAtIndex:0];
    NSString *userDataPath = [documentsPath stringByAppendingPathComponent:@"UserData.plist"];
    
    //look for plist in documents, if not there, retrieve from mainBundle
    if (![fileManager fileExistsAtPath:userDataPath]){
        userDataPath = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
    }
    
    self.calendarData = [NSMutableDictionary dictionaryWithContentsOfFile:userDataPath];
}

- (void) recordData: (NSString *)date hours:(double)hours wage:(double)wage {
    //When stop button is pressed, record new data to plist
    //date is NSString in format yyyymmdd
    //hours and wage are NSNumbers representing hours worked, and wage per hour
    //NOTE: 1 wage per day. Currently new wage will not override.
    
    //get existing data for today's date
    NSArray *existingData;
    existingData=[self.calendarData objectForKey:date];
    if (existingData != nil){
        hours = hours+[existingData[0] doubleValue];
        wage = wage+[existingData[1] doubleValue];
    }
    //create new array with today's data
    existingData = [NSArray arrayWithObjects: [NSNumber numberWithDouble:hours], [NSNumber numberWithDouble:wage], nil];
    
    //add array back to calendar
    [self.calendarData setObject:existingData forKey:date];
}

- (void) saveCalendarData {
    //Save calendar back to plist in documents
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [directoryPaths objectAtIndex:0];
    NSString *userDataPath = [documentsPath stringByAppendingPathComponent:@"UserData.plist"];
    
    [self.calendarData writeToFile:userDataPath atomically:YES];
    

}

@end

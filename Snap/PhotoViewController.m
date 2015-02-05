//
//  ViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "PhotoViewController.h"
#import <Parse/Parse.h>
#import "DynamicTableViewCell.h"
#import "User.h"
#import "Photo.h"

@interface PhotoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [User load];

    User *currentUser = [User currentUser];

    // User sign up
    [User signUpWithUsername:@"chgiersch" password:@"password" email:@"chgiersch@gmail.com" withCompletion:^(NSError *error)
     {
         if (error)
         {
             NSLog(@"%@", error);
         }
     }];


    // Create and save photo to current user
    Photo *photo = (Photo *)[PFObject objectWithClassName:@"Photo"];
    photo.caption = @"Photo 1";
    [Photo savePhoto:photo withUser:currentUser withCompletion:^(NSError *error)
     {

     }];


    // Get most recent photos from current user
    [User retrieveRecent48HourPhotosFromUser:currentUser withCompletion:^(NSArray *photosArray)
     {
         Photo *photo1 = photosArray.firstObject;
         NSLog(@"%@", photo1.caption);
     }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end

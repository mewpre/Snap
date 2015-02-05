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

//    Photo *photo = (Photo *)[PFObject objectWithClassName:@"Photo"];
//    photo.caption = @"My first caption";
//
//    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded)
//        {
//            // The object has been saved.
//            NSLog(@"Photo object saved");
//        }
//        else
//        {
//            // There was a problem, check error.description
//            NSLog(@"Error");
//        }
//    }];




    




    [PFUser logInWithUsernameInBackground:@"chgiersch" password:@"password"
                                    block:^(PFUser *user, NSError *error)
    {
        if (user)
        {
            // Do stuff after successful login.
            NSLog(@"%@ logged in", user.username);

        }
        else
        {
            // The login failed. Check error to see why.
            NSLog(@"%@", error);
        }
    }];

    // Retrieve user object from parse
    PFQuery *query = [PFQuery queryWithClassName:@"User"];

    [query getObjectInBackgroundWithId:@"mocCdm36ve" block:^(PFObject *user, NSError *error)
    {
        // Do something with the returned PFObject in the gameScore variable.
        PFUser *retrievedUser = (PFUser *)user;
        NSLog(@"%@", retrievedUser.username);
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

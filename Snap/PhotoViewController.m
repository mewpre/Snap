//
//  ViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "PhotoViewController.h"
#import <Parse/Parse.h>
//#import "AppDelegate.h"
#import "DynamicTableViewCell.h"
#import "User.h"
#import "Photo.h"

@interface PhotoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSUserDefaults *defaults;
@property User *currentUser;

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //    Create THE USER to save friends to
    self.defaults = [NSUserDefaults standardUserDefaults];
    if (![self.defaults objectForKey:@"SnapUsername"])
    {
        UIAlertView *alert = [[UIAlertView alloc] init]; // dont need an if statement for action mode delete button possibly assumes first button is an action button
        alert.title =@"Please enter a User Name";
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert addButtonWithTitle:@"Next!"];
        alert.delegate = self;
        [alert show];
    }
    else
    {
        NSString *username = [self.defaults objectForKey:@"SnapUsername"];
        [User loginWithUsername:username andPassword:@"password" withCompletionBlock:^(NSError *error) {
            NSLog(@"Logged in as: %@", username);
            self.currentUser = [User currentUser];
        }];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"username";
    //    return [[self.postsArray objectAtIndex:section] objectForKey:@"headertext"];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 80.0)];
    UIView *grayLineView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 79.0, 320.0, 1.0)];
    grayLineView.backgroundColor = [UIColor grayColor];
    UIImage *image = [UIImage imageNamed:@"Bruce"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(16.0, 20.0, 40.0, 40.0)];
    imageView.image = image;
    [headerView addSubview:imageView];
    [headerView addSubview:grayLineView];
    return headerView;
}


//- (void)populateDatabase
//{
//    // Create 4 users
//    [User signUpWithUsername:@"bestMomEver" password:@"password" email:@"mom@gmail.com" withCompletion:^(NSError *error) {
//        Photo *momPhoto = [Photo new];
//        momPhoto.caption = @"Mom's first photo!";
//        [Photo savePhoto:momPhoto withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:momPhoto forKey:@"photos"];
//        [momPhoto saveInBackground];
//
//        Photo *momPhoto2 = [Photo new];
//        momPhoto.caption = @"My favorite child...my daughter!";
//        [Photo savePhoto:momPhoto2 withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:momPhoto2 forKey:@"photos"];
//        [momPhoto2 saveInBackground];
//    }];
//
//
//    [User signUpWithUsername:@"quietTypeDad" password:@"password" email:@"dad@gmail.com" withCompletion:^(NSError *error) {
//        Photo *dadPhoto = [Photo new];
//        dadPhoto.caption = @"I'm the father, I like photos of my kids!";
//        [Photo savePhoto:dadPhoto withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:dadPhoto forKey:@"photos"];
//        [dadPhoto saveInBackground];
//
//        Photo *dadPhoto2 = [Photo new];
//        dadPhoto2.caption = @"I love golf! GOLF, GOLF, GOLF!!!";
//        [Photo savePhoto:dadPhoto2 withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:dadPhoto2 forKey:@"photos"];
//        [dadPhoto2 saveInBackground];
//    }];
//
//
//    [User signUpWithUsername:@"crazySister" password:@"password" email:@"sis@gmail.com" withCompletion:^(NSError *error) {
//        Photo *sisPhoto = [Photo new];
//        sisPhoto.caption = @"My little brother is SO annoying!";
//        [Photo savePhoto:sisPhoto withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:sisPhoto forKey:@"photos"];
//        [sisPhoto saveInBackground];
//
//        Photo *sisPhoto2 = [Photo new];
//        sisPhoto2.caption = @"Me and my BFF. We're so hot!";
//        [Photo savePhoto:sisPhoto2 withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:sisPhoto2 forKey:@"photos"];
//        [sisPhoto2 saveInBackground];
//    }];
//
//
//    [User signUpWithUsername:@"stupidLittleBrother" password:@"password" email:@"bro@gmail.com" withCompletion:^(NSError *error) {
//        Photo *broPhoto = [Photo new];
//        broPhoto.caption = @"Video games!";
//        [Photo savePhoto:broPhoto withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:broPhoto forKey:@"photos"];
//        [broPhoto saveInBackground];
//
//        Photo *broPhoto2 = [Photo new];
//        broPhoto2.caption = @"I had over 100 headshots last night in CoD";
//        [Photo savePhoto:broPhoto2 withUser:[User currentUser] withCompletion:nil];
//        [[User currentUser] addObject:broPhoto2 forKey:@"photos"];
//        [broPhoto2 saveInBackground];
//    }];
//
//    // Create 2 pictures for each user and save
//
//    // Add respective 2 pair of photos to each users PHOTO relation
//
//}

//    User *currentUser = [User currentUser];
// User sign up
//
//
//    // Create and save photo to current user
//    Photo *photo = (Photo *)[PFObject objectWithClassName:@"Photo"];
//    photo.caption = @"Photo 1";
//    [Photo savePhoto:photo withUser:currentUser withCompletion:^(NSError *error)
//     {
//
//     }];
//
//
//    // Get most recent photos from current user
//    [User retrieveRecent48HourPhotosFromUser:currentUser withCompletion:^(NSArray *photosArray)
//     {
//         Photo *photo1 = photosArray.firstObject;
//         NSLog(@"%@", photo1.caption);
//     }];

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:[User description] inManagedObjectContext:self.context];
    
    NSString *username = [[alertView textFieldAtIndex:0] text];
    //    NSString *email = [[alertView textFieldAtIndex:1] text];
    //    NSString *password = [[alertView textFieldAtIndex:2] text];
    
    [User signUpWithUsername:username password:@"password" email:@"chgiersch@gmail.com" withCompletion:^(NSError *error)
     {
         if (error)
         {
             NSLog(@"%@", error);
         }
         self.currentUser = [User currentUser];
         //         [self populateDatabase];
     }];
    
    // Save instance of App User (but can also use CurrentUser method)
    //    self.theUser = newUser;
    
    [self.defaults setObject:username forKey:@"SnapUsername"];
    [self.defaults synchronize];
    
    // Load photos onto feed here...
}



@end

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
//@property NSArray *photoArray;  // To hold 1 or many photos to display for feed or photo view

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.photosArray = [NSArray new];

    [User retrieveMostRecentPhotos:^(NSArray *photosArray) {
        NSLog(@"FUCK");
    }];

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

//             // Add to usersFollowing relation of current user
//            PFRelation *relation = [[PFUser currentUser] relationForKey:@"usersFollowing"];
//            PFUser *aUser = [PFUser objectWithoutDataWithObjectId:@"ouABGYJhjI"];
//            [relation addObject:aUser];
//            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                NSLog(@"Save relation complete");
//                if (error)
//                {
//                    NSLog(@"%@", error);
//                }
//
//            }];

            // Call loadPhotosInFeed method here... (and in Alert view)
            [User retrieveMostRecentPhotos:^(NSArray *photosArray) {
                NSLog(@"Number of photos retrieved: %lu", (unsigned long)photosArray.count);
                self.photosArray = photosArray;
                [self.tableView reloadData];
            }];
        }];
//        [self populateDatabase];
    }
}

//---------------------------------------------    Show View    ----------------------------------------------
#pragma mark - Show View
- (void)showPhotoViewControllerWithPhotos:(NSArray *)array
{
    PhotoViewController *photoVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PhotoViewController class])];
    photoVC.photosArray = array;
    [self.navigationController pushViewController:photoVC animated:YES];
}

//---------------------------------------------    Table View    ----------------------------------------------
#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.photosArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //get image from query
    Photo *photo = self.photosArray[indexPath.row];
    cell.imageView.image = [photo getUIImage];
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

    // Set image here
    UIImage *image = [UIImage imageNamed:@"Bruce"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(16.0, 20.0, 40.0, 40.0)];
    imageView.image = image;
    [headerView addSubview:imageView];
    [headerView addSubview:grayLineView];
    return headerView;
}


//----------------------------------------------    Alert View (Login)    ----------------------------------------------
#pragma mark - Alert View (Login)
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
         [self.defaults setObject:username forKey:@"SnapUsername"];
         [self.defaults synchronize];
         NSLog(@"Signed up as: %@", username);

         //         [self populateDatabase];

         // Call loadPhotosInFeed method here...
     }];
}


//---------------------------------------------    Show View    ----------------------------------------------
#pragma mark - Show View
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Photo *photo = self.photosArray[indexPath.row];
    NSArray *array = [[NSArray alloc] initWithObjects:photo, nil];
    [self showPhotoViewControllerWithPhotos:array];
}

//-------------------------------------------    Populate Database    ----------------------------------------------
#pragma mark - Populate Database
- (void)populateDatabase
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tfss-16e3e245-6624-46a3-ab5a-d80d4f8797b9-file" ofType:@"txt"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
//    PFFile *file = [PFFile fileWithData:imageData];
    UIImage *image = [UIImage imageWithData:imageData];

    // Create 4 users
    [User logOut];
//    [User signUpWithUsername:@"bestMomEver" password:@"password" email:@"mom@gmail.com" withCompletion:^(NSError *error) {
//        User *momUser = [User currentUser];
//        [User loginWithUsername:momUser.username andPassword:@"password" withCompletionBlock:^(NSError *error) {
//            Photo *momPhoto = [Photo new];
////            momPhoto.imageFile = file;
//            [momPhoto savePhotoWithImage:image caption:@"Mom's first photo!" withUser:momUser withCompletion:^(NSError *error) {
////                [currentUser addObject:momPhoto forKey:@"photos"];
////                [momPhoto saveInBackground];
//            }];
//
//            Photo *momPhoto2 = [Photo new];
////            momPhoto.imageFile = file;
//            [momPhoto2 savePhotoWithImage:image caption:@"My favorite child...my daughter!" withUser:momUser withCompletion:^(NSError *error) {
////                [currentUser addObject:momPhoto2 forKey:@"photos"];
////                [momPhoto2 saveInBackground];
//                [User logOut];
//            }];
//        }];
//    }];

//    [User signUpWithUsername:@"quietTypeDad" password:@"password" email:@"dad@gmail.com" withCompletion:^(NSError *error) {
//        User *dadUser = [User currentUser];
//        [User loginWithUsername:dadUser.username andPassword:@"password" withCompletionBlock:^(NSError *error) {
//            Photo *dadPhoto = [Photo new];
////            dadPhoto.imageFile = file;
//            [dadPhoto savePhotoWithImage:image caption:@"I love golf. GOLF, GOLF, GOLF!!" withUser:dadUser withCompletion:^(NSError *error) {
////                [currentUser addObject:dadPhoto forKey:@"photos"];
////                [dadPhoto saveInBackground];
//            }];
//
//            Photo *dadPhoto2 = [Photo new];
//            //            dadPhoto2.imageFile = file;
//            [dadPhoto2 savePhotoWithImage:image caption:@"I love pictures of my kids" withUser:dadUser withCompletion:^(NSError *error) {
////                [currentUser addObject:dadPhoto2 forKey:@"photos"];
////                [dadPhoto2 saveInBackground];
//                [User logOut];
//            }];
//        }];
//    }];
//
//    [User signUpWithUsername:@"crazySister" password:@"password" email:@"sis@gmail.com" withCompletion:^(NSError *error) {
//        User *sisUser = [User currentUser];
//        [User loginWithUsername:sisUser.username andPassword:@"password" withCompletionBlock:^(NSError *error) {
//            Photo *sisPhoto = [Photo new];
//            [sisPhoto savePhotoWithImage:image caption:@"My little brother is SO annoying!" withUser:sisUser withCompletion:^(NSError *error) {
////                [currentUser addObject:sisPhoto forKey:@"photos"];
////                [sisPhoto saveInBackground];
//            }];
//
//            Photo *sisPhoto2 = [Photo new];
//            [sisPhoto2 savePhotoWithImage:image caption:@"Me and my BFF. We're so hot!" withUser:sisUser withCompletion:^(NSError *error) {
////                [currentUser addObject:sisPhoto2 forKey:@"photos"];
////                [sisPhoto2 saveInBackground];
//                [User logOut];
//            }];
//        }];
//    }];
//
//    [User signUpWithUsername:@"stupidLittleBrother" password:@"password" email:@"bro@gmail.com" withCompletion:^(NSError *error) {
//        User *broUser = [PFUser currentUser];
//        [User loginWithUsername:broUser.username andPassword:@"password" withCompletionBlock:^(NSError *error) {
//            Photo *broPhoto = [Photo new];
//            [broPhoto savePhotoWithImage:image caption:@"Video games!" withUser:broUser withCompletion:^(NSError *error) {
////                [currentUser addObject:broPhoto forKey:@"photos"];
////                [broPhoto saveInBackground];
//            }];
//
//            Photo *broPhoto2 = [Photo new];
//            [broPhoto2 savePhotoWithImage:image caption:@"I had over 100 headshots last night in CoD" withUser:broUser withCompletion:^(NSError *error) {
////                [currentUser addObject:broPhoto2 forKey:@"photos"];
////                [broPhoto2 saveInBackground];
//                [User logOut];
//            }];
//        }];
//    }];
}

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

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    //    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:[User description] inManagedObjectContext:self.context];
//    
//    NSString *username = [[alertView textFieldAtIndex:0] text];
//    //    NSString *email = [[alertView textFieldAtIndex:1] text];
//    //    NSString *password = [[alertView textFieldAtIndex:2] text];
//    
//    [User signUpWithUsername:username password:@"password" email:@"chgiersch@gmail.com" withCompletion:^(NSError *error)
//     {
//         if (error)
//         {
//             NSLog(@"%@", error);
//         }
//         self.currentUser = [User currentUser];
//         //         [self populateDatabase];
//     }];
//    
//    // Save instance of App User (but can also use CurrentUser method)
//    //    self.theUser = newUser;
//    
//    [self.defaults setObject:username forKey:@"SnapUsername"];
//    [self.defaults synchronize];
//    
//    // Load photos onto feed here...
//}



@end

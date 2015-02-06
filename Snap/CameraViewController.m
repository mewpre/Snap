//
//  CameraViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "CameraViewController.h"
#import "UploadDetailViewController.h"
#import <Parse/Parse.h>
#import "Photo.h"
#import "User.h"


@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UploadDelegate>

@property UITextField *captionTextField;
@property UIImage *chosenImage;
@property UploadDetailViewController *udvc;

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
}

- (IBAction)onTakePictureButtonTapped:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)onSelectPictureButtonTapped:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self performSegueWithIdentifier:@"uploadDetailSegue" sender:self];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)dismissUploadViewController
{
    [self.udvc dismissViewControllerAnimated:YES completion:NULL];
    [self.tabBarController setSelectedIndex:3];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.udvc = segue.destinationViewController;
    self.udvc.delegate = self;
    self.udvc.image = self.chosenImage;
}


@end

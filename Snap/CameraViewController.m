//
//  CameraViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "CameraViewController.h"
#import <Parse/Parse.h>
#import "Photo.h"


@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property UITextField *captionTextField;

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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;

    [picker dismissViewControllerAnimated:YES completion:NULL];

    //Maybe do segue here into the Upload View Controller/Upload Detail View Controller
    //Just pass chosenImage in the segue

}

- (void)postPictureButtonPressed {
    Photo *photo;
    photo.caption = self.captionTextField.text;
    
//    photo[@"user"] = currentUser;
    
}

- (void)convertImageToPFFile {
    
    UIImage *image =///
    UIImageView *imageView = image;
    NSData *imageData = UIImagePNGRepresentation(imageView.image);
    
    [file saveInBackground];
    
    
    
    
//    PFFile *theImage = [object objectForKey:@"image"];
//    NSData *imageData = [theImage getData];
//    UIImage *image = [UIImage imageWithData:imageData];
//    UIImageView *imageCell = (UIImageView *)[cell viewWithTag:105];
//    imageCell.image =image;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

@end

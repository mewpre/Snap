//
//  UploadDetailViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "UploadDetailViewController.h"
#import "Photo.h"

@interface UploadDetailViewController ()

@property (strong, nonatomic) IBOutlet UITextField *captionTextField;
@property (strong, nonatomic) IBOutlet UITextField *tagUsersTextField;


@end

@implementation UploadDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
}

- (IBAction)onShareButtonTapped:(id)sender
{
    NSArray *activityItems = @[self.image, self.captionTextField.text];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[]];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
    [self presentViewController:activityVC animated:TRUE completion:nil];
}

- (IBAction)onPostButtonTapped:(id)sender
{
    Photo *currentPhoto = [Photo new];
    NSData *imageData = UIImagePNGRepresentation(self.image);
    PFFile *file = [PFFile fileWithData:imageData];
    currentPhoto.imageFile = file;
    currentPhoto.caption = self.captionTextField.text;
    [currentPhoto savePhoto:currentPhoto withUser:[User currentUser] withCompletion:nil];
}

- (IBAction)onCancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

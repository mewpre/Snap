//
//  UploadDetailViewController.m
//  Snap
//
//  Created by Yi-Chin Sun on 2/3/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "UploadDetailViewController.h"
#import "Photo.h"

@interface UploadDetailViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *captionTextField;
@property (strong, nonatomic) IBOutlet UITextField *tagUsersTextField;


@end

@implementation UploadDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
    self.captionTextField.clearsOnBeginEditing = YES;
    self.tagUsersTextField.clearsOnBeginEditing = YES;
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
    [currentPhoto savePhotoWithImage:self.image caption:self.captionTextField.text withUser:[User currentUser] withCompletion:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)onCancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

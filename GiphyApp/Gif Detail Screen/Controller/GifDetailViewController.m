//
//  GifDetailViewController.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifDetailViewController.h"
#import "GiphyApp-Swift.h"

@interface GifDetailViewController ()

@property(nonatomic, strong) GifDetailViewModel *viewModel;

//outlets
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *trendingView;
@property (weak, nonatomic) IBOutlet UILabel *titleGifLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicationDateGifLabel;

//buttons
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

//adaptive constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adaptiveHeightGifConstraint;


@end

@implementation GifDetailViewController

- (instancetype)initWithViewModel:(GifDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //adaptiveConstraint
    self.adaptiveHeightGifConstraint.constant =  self.view.frame.size.width * self.viewModel.gifEntity.originImage.height /self.viewModel.gifEntity.originImage.width;
    //labels
    self.titleGifLabel.text = self.viewModel.gifEntity.title.capitalizedString;
    self.publicationDateGifLabel.text = [NSDateFormatter localizedStringFromDate:self.viewModel.gifEntity.publishingDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    //buttons
    self.dismissButton.layer.cornerRadius = self.dismissButton.frame.size.width / 2;
    
    //views
    self.gifView.layer.cornerRadius = 30;
    

}


//MARK: - Actions

- (IBAction)dismissActionHandler:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)shareActionHandler:(id)sender {
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"this is GIF"] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)saveActionHandler:(id)sender {
    //save at least one image
    UIImageWriteToSavedPhotosAlbum(self.gifView.image, nil, nil, nil);
    //add alert with action sheet
}

@end

//
//  GifDetailViewController.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifDetailViewController.h"
#import "NSDate+FormattedString.h"
#import "GiphyApp-Swift.h"

@interface GifDetailViewController ()

@property(nonatomic, strong) GifDetailViewModel *viewModel;

//outlets
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *trendingView;
@property (weak, nonatomic) IBOutlet UILabel *titleGifLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicationDateGifLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

//buttons
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

//adaptive constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adaptiveHeightGifConstraint;
//activityIndicator
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation GifDetailViewController

- (instancetype)initWithViewModel:(GifDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

//MARK: - ViewControoler lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //bind to viewVodel
    [self bindToViewModel];
    [self setupViews];
}



-(void)setupViews {
    //activity indicator
    [self.activityIndicator startAnimating];
    
    //adaptiveConstraint
    
    self.adaptiveHeightGifConstraint.constant = self.viewModel.gifEntity.originImage.height * UIScreen.mainScreen.bounds.size.width / self.viewModel.gifEntity.originImage.width;
    //labels
    self.titleGifLabel.text = self.viewModel.gifEntity.title.capitalizedString;
    self.publicationDateGifLabel.text = self.viewModel.gifEntity.publishingDate.formattedString;
    self.userLabel.text = self.viewModel.gifEntity.username;
    
    if (self.viewModel.gifEntity.trendingDate != nil) {
        [self.trendingView setHidden:NO];
    } else {
        [self.trendingView setHidden:YES];
    }
    
    //buttons
    self.activityIndicator.hidesWhenStopped = YES;
    
    self.shareButton.hidden = YES;
    self.shareButton.userInteractionEnabled = NO;
    self.saveButton.hidden = YES;
    self.saveButton.userInteractionEnabled = NO;
    
    CGFloat buttonRadius = self.dismissButton.frame.size.width / 2;
    self.dismissButton.layer.cornerRadius  = buttonRadius;
    self.dismissButton.layer.shadowColor   = UIColor.blackColor.CGColor;
    self.dismissButton.layer.shadowOffset  = CGSizeMake(0, 0);
    self.dismissButton.layer.shadowRadius  = buttonRadius;
    self.dismissButton.layer.shadowOpacity = 5;
}

//MARK: - Binding
-(void)bindToViewModel {
    __weak typeof(self) weakself = self;
    [self.viewModel loadGif];
    self.viewModel.didUpdate = ^ {
        [weakself viewModelDidUpdate];
    };
}

- (void)viewModelDidUpdate {
    [UIView transitionWithView:self.gifView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.activityIndicator stopAnimating];
        self.gifView.image = [UIImage animatedImageWithData:self.viewModel.gifData];
        
        self.shareButton.hidden = NO;
        self.shareButton.userInteractionEnabled = YES;
        self.saveButton.hidden = NO;
        self.saveButton.userInteractionEnabled = YES;
    } completion:nil];
}



//MARK: - Actions

- (IBAction)dismissActionHandler:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareActionHandler:(id)sender {
    NSData *gifData = self.viewModel.gifData;
    NSString *gifTitle = self.viewModel.gifEntity.title.capitalizedString;
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[gifData, gifTitle] applicationActivities:nil];
    
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed && activityType == UIActivityTypeSaveToCameraRoll) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saving" message:@"GIF saved to camera roll" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    };
    
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        activityVC.popoverPresentationController.sourceView = self.shareButton;
        activityVC.popoverPresentationController.sourceRect = self.shareButton.bounds;
    }
    
    [self presentViewController:activityVC animated:YES completion:nil];
}


- (IBAction)saveActionHandler:(id)sender {
    // Add to CoreData
}

@end

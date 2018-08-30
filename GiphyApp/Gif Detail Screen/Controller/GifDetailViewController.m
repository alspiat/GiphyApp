//
//  GifDetailViewController.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifDetailViewController.h"
#import "NSDate+FormattedString.h"
#import "CoreDataManager.h"
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
@property (weak, nonatomic) IBOutlet UIButton *animateButton;

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
    
    self.adaptiveHeightGifConstraint.constant = self.viewModel.gifEntity.originalImage.height * UIScreen.mainScreen.bounds.size.width / self.viewModel.gifEntity.originalImage.width;
    //labels
    self.titleGifLabel.text = self.viewModel.gifEntity.title.capitalizedString;
    self.publicationDateGifLabel.text = self.viewModel.gifEntity.publishingDate.formattedString;
    self.userLabel.text = self.viewModel.gifEntity.username;
    
    if (self.viewModel.gifEntity.trendingDate != nil) {
        [self.trendingView setHidden:NO];
    } else {
        [self.trendingView setHidden:YES];
    }
    
    if (self.viewModel.isSaved) {
        [self.saveButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    } else {
        [self.saveButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    }
    
    //buttons
    self.activityIndicator.hidesWhenStopped = YES;
    
    CGFloat buttonRadius = self.dismissButton.frame.size.width / 2;
    self.dismissButton.layer.cornerRadius  = buttonRadius;
    self.dismissButton.layer.shadowColor   = UIColor.blackColor.CGColor;
    self.dismissButton.layer.shadowOffset  = CGSizeMake(0, 0);
    self.dismissButton.layer.shadowRadius  = buttonRadius;
    self.dismissButton.layer.shadowOpacity = 5;
    
    self.animateButton.layer.cornerRadius  = buttonRadius;
    self.animateButton.layer.shadowColor   = UIColor.blackColor.CGColor;
    self.animateButton.layer.shadowOffset  = CGSizeMake(0, 0);
    self.animateButton.layer.shadowRadius  = buttonRadius;
    self.animateButton.layer.shadowOpacity = 5;
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
        self.gifView.image = nil;
        self.gifView.image = self.viewModel.gifImage;
    } completion:nil];
    
    if (self.viewModel.isAnimating) {
        [self.animateButton setBackgroundImage:[UIImage imageNamed:@"stop-button"] forState:UIControlStateNormal];
    } else {
        [self.animateButton setBackgroundImage:[UIImage imageNamed:@"play-button"] forState:UIControlStateNormal];
    }
}



//MARK: - Actions

- (IBAction)animatingButtonTapped:(UIButton *)sender {
    if (self.viewModel.isAnimating) {
        [self.viewModel stopAnimating];
    } else {
        [self.viewModel startAnimating];
    }
}

- (IBAction)dismissActionHandler:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareActionHandler:(id)sender {
    NSData *gifData = self.viewModel.gifData;
    NSString *gifTitle = self.viewModel.gifEntity.title.capitalizedString;
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[gifData, gifTitle] applicationActivities:nil];
    
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed && activityType == UIActivityTypeSaveToCameraRoll) {
            [self showInfoAlert:@"Saving" message:@"GIF saved to camera roll"];
        }
    };
    
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        activityVC.popoverPresentationController.sourceView = self.shareButton;
        activityVC.popoverPresentationController.sourceRect = self.shareButton.bounds;
    }
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)showInfoAlert:(NSString *)title message:(NSString *)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)saveActionHandler:(id)sender {
    if (!self.viewModel.isSaved) {
        if ([self.viewModel saveToPersistance]) {
            [self.saveButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            [self showInfoAlert:@"Saving" message:@"GIF saved to persistance"];
        }
    } else {
        if ([self.viewModel removeFromPersistance]) {
            [self.saveButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
            [self showInfoAlert:@"Removing" message:@"GIF removed from persistance"];
        }
    }
}

@end

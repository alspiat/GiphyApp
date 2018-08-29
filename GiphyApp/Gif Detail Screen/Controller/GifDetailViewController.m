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
    self.activityIndicator.hidesWhenStopped = YES;
    //adaptiveConstraint
    self.adaptiveHeightGifConstraint.constant =  self.view.frame.size.width * self.viewModel.gifEntity.originImage.height /self.viewModel.gifEntity.originImage.width;
    //labels
    self.titleGifLabel.text = self.viewModel.gifEntity.title.capitalizedString;
    self.publicationDateGifLabel.text = [NSDateFormatter localizedStringFromDate:self.viewModel.gifEntity.publishingDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    //buttons
    self.dismissButton.layer.cornerRadius = self.dismissButton.frame.size.width / 2;
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
        self.gifView.image = self.viewModel.gifImage;
    } completion:nil];
}



//MARK: - Actions

- (IBAction)dismissActionHandler:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)shareActionHandler:(id)sender {
    NSData* gifData = [self loadGifFromFolder];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[gifData] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
    
    if (activityVC.beingDismissed) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Save GIF to camera roll" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (IBAction)saveActionHandler:(id)sender {
    //add alert with action sheet
    UIAlertController * alertWithActionSheet = [UIAlertController alertControllerWithTitle:nil
                                                                     message: @"GIF was saved"
                                                              preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionSaveToDevice = [UIAlertAction actionWithTitle:@"Save on device" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //save on device
        UIImageWriteToSavedPhotosAlbum(self.gifView.image, nil, nil, nil);

        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Save GIF to camera roll" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
    }];
    
    UIAlertAction *actionSaveInApp = [UIAlertAction actionWithTitle:@"Add to favorites" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //add to saved4
        NSLog(@"add to core data to saveed");
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //add to saved4
        NSLog(@"cancelled");
    }];
    
    [alertWithActionSheet addAction:actionSaveToDevice];
    [alertWithActionSheet addAction:actionSaveInApp];
    [alertWithActionSheet addAction:actionCancel];
    [self presentViewController:alertWithActionSheet animated:YES completion:nil];
}


//MARK: - Load Image From Folder
-(NSData*)loadGifFromFolder {
    AppFileManager *fileManager = [[AppFileManager alloc] init];
    NSString *filename = [NSString stringWithFormat:@"%@.%@", self.viewModel.gifEntity.id, @"gif"];
    NSLog(@"File: %@", filename);
    NSData *data = [fileManager dataFromFileWithFilename:filename folder:AppFileManager.previewsPath];
    return data;
}

@end

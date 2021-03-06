//
//  GifListViewController.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifListViewController.h"
#import "GifListViewController+CollectionView.h"
#import "GifListViewController+SearchTextField.h"
#import "GifCollectionViewCell.h"
#import "ButtonConstants.h"

@interface GifListViewController ()

@property (readwrite, weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (readwrite, nonatomic, strong) id<GifListViewModel> viewModel;
@property (weak, nonatomic) IBOutlet UILabel *noItemsLabel;


@end

@implementation GifListViewController

- (instancetype)initWithViewModel:(id<GifListViewModel>)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.title;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    GifCollectionViewLayout *layout = (GifCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadList) forControlEvents:UIControlEventValueChanged];
    refreshControl.backgroundColor = UIColor.clearColor;
    refreshControl.tintColor = UIColor.whiteColor;
    self.collectionView.refreshControl = refreshControl;
    
    UIView *paddingView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 10, self.searchTextField.frame.size.height)];
    self.searchTextField.leftView = paddingView;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTextField.delegate = self;

    [self.collectionView registerNib:[UINib nibWithNibName:gifCellNibName bundle:NSBundle.mainBundle] forCellWithReuseIdentifier:gifCellIdentifier];
    
    //add bookmark button
    [self setupBookmarkButton];
    
    //add settings button
    [self setupSettingsButton];
   
    //bind to viewModel
    [self bindToViewModel];
    [self.viewModel loadDataIfNeededFromIndex:0];
}

//MARK: - Buttons
-(void)setupBookmarkButton {
    UIImage *buttonImage = [[UIImage imageNamed:gifFavoritesButtonImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationItem.leftBarButtonItem setImage:buttonImage];
    [self.navigationItem.leftBarButtonItem setTarget:self];
    [self.navigationItem.leftBarButtonItem setAction:@selector(favouritesButtonTapped:)];
}

-(void)setupSettingsButton {
    UIImage *settingsImage = [[UIImage imageNamed:gifSettingsButtonImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:settingsImage];
    imgView.layer.contentsGravity =kCAGravityResizeAspect;
    
    self.navigationItem.rightBarButtonItem.image = imgView.image;
    [self.navigationItem.rightBarButtonItem setTarget:self];
    [self.navigationItem.rightBarButtonItem setAction:@selector(settingsButtonTapped:)];
}

//MARK: - Binding
- (void)bindToViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.didUpdate = ^{
        [weakSelf viewModelDidUpdate];
    };
}

- (void)viewModelDidUpdate {
    if (self.collectionView.refreshControl.refreshing) {
        [self.collectionView.refreshControl endRefreshing];
    }
    
    if (self.viewModel.numberOfRows == 0) {
        [self.noItemsLabel setHidden:NO];
    } else {
        [self.noItemsLabel setHidden:YES];
    }
    
    self.noItemsLabel.text = self.viewModel.message;
    
    [self.collectionView performBatchUpdates:^{
        for (NSInteger i = [self.collectionView numberOfItemsInSection:0]; i < self.viewModel.numberOfRows; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
        }
    } completion:nil];
    
//    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//MARK: - Button's Actions
- (void)reloadList {
    [self.viewModel clearData];
    [self.collectionView reloadData];
    [self.viewModel loadDataIfNeededFromIndex:0];
}

- (IBAction)searchButtonTapped:(UIButton *)sender {
    if (![self.searchTextField.text isEqualToString:@""]) {
        [Navigation.shared showSearchingGifsWithQuery:self.searchTextField.text];
    }
}

- (IBAction)favouritesButtonTapped:(UIBarButtonItem *)sender {
    [Navigation.shared showFavouritesGifs];
}

-(IBAction)settingsButtonTapped:(id)sender {
    [Navigation.shared showSettingsController];
}

@end

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
    // Do any additional setup after loading the view from its nib.
}

@end

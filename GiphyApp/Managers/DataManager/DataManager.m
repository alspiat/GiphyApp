//
//  DataManager.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/28/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "DataManager.h"
#import "GiphyApp-Swift.h"

static NSString * const dataType = @"gif";

@implementation DataManager

+ (id<NetworkCancelable>)loadImage:(GifImage*)gifImage withName:(NSString *)filename folder:(NSString*)folderPath
                             saving:(BOOL)saving completionHandler:(BlockWithImage)completionHandler {
    AppFileManager *fileManager = [[AppFileManager alloc] init];
    NSData *data = [fileManager dataFromFileWithFilename:filename folder:folderPath];
    
    if (data) {
        UIImage *image = [UIImage animatedImageWithData:data];
        completionHandler(image);
        
        return nil;
    } else {
        APIService *service = APIService.shared;
        NSURL *url = [NSURL URLWithString:gifImage.url];
        
        id<NetworkCancelable> dataTask = [service fetchDataWithURL:url completionHandler:^(NSData *data) {
            UIImage *image = [UIImage animatedImageWithData:data];
            if (saving) {
                [fileManager createFile:filename data:data folder:folderPath];
            }
            completionHandler(image);
        }];
        
        return dataTask;
    }
}

+ (id<NetworkCancelable>)loadPreviewImage:(GifEntity*)gifEntity completionHandler:(BlockWithImage)completionHandler {
    NSString *filename = [NSString stringWithFormat:@"%@.%@", gifEntity.id, dataType];
    return [self loadImage:gifEntity.previewImage withName:filename folder: AppFileManager.previewsPath saving:YES completionHandler:completionHandler];
}

+ (id<NetworkCancelable>)loadOriginalImage:(GifEntity*)gifEntity completionHandler:(BlockWithImage)completionHandler {
    NSString *filename = [NSString stringWithFormat:@"%@.%@", gifEntity.id, dataType];
    return [self loadImage:gifEntity.originImage withName:filename folder: AppFileManager.originalsPath saving:NO completionHandler:completionHandler];
}

@end

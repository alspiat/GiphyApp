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

+ (id<NetworkCancelable>)loadImageData:(GifImage*)gifImage withName:(NSString *)filename folder:(NSString*)folderPath
                             saving:(BOOL)saving completionHandler:(BlockWithData)completionHandler {
    AppFileManager *fileManager = [[AppFileManager alloc] init];
    NSData *data = [fileManager dataFromFileWithFilename:filename folder:folderPath];
    
    if (data) {
        completionHandler(data);
        return nil;
    } else {
        APIService *service = APIService.shared;
        NSURL *url = [NSURL URLWithString:gifImage.url];
        
        id<NetworkCancelable> dataTask = [service fetchDataWithURL:url completionHandler:^(NSData *data) {
            if (saving) {
                [fileManager createFile:filename data:data folder:folderPath];
            }
            completionHandler(data);
        }];
        
        return dataTask;
    }
}

+ (id<NetworkCancelable>)loadPreviewImageData:(GifEntity*)gifEntity completionHandler:(BlockWithData)completionHandler {
    NSString *filename = [NSString stringWithFormat:@"%@.%@", gifEntity.id, dataType];
    return [self loadImageData:gifEntity.previewImage withName:filename folder: AppFileManager.previewsPath saving:YES completionHandler:completionHandler];
}

+ (id<NetworkCancelable>)loadOriginalImageData:(GifEntity*)gifEntity completionHandler:(BlockWithData)completionHandler {
    NSString *filename = [NSString stringWithFormat:@"%@.%@", gifEntity.id, dataType];
    return [self loadImageData:gifEntity.originImage withName:filename folder: AppFileManager.originalsPath saving:NO completionHandler:completionHandler];
}

@end

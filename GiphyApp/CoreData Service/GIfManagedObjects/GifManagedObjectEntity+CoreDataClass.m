//
//  GifManagedObjectEntity+CoreDataClass.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectEntity+CoreDataClass.h"
#import "GifManagedObjectImage+CoreDataClass.h"
#import "GiphyApp-Swift.h"



@implementation GifManagedObjectEntity

- (GifManagedObjectEntity*)initWithItem:(GifEntity *)item context:(NSManagedObjectContext *)context {
    
    GifManagedObjectEntity *gifMO = [NSEntityDescription insertNewObjectForEntityForName:gifEntityName inManagedObjectContext:context];
    
    //properties
    [gifMO setId: item.id];
    gifMO.title = item.title;
    gifMO.username = item.username;
    gifMO.publishingDate = item.publishingDate;
    gifMO.trendingDate = item.trendingDate;
    
    //images
    gifMO.originalImage = [[GifManagedObjectImage alloc]initWithOriginalImage:item context:context];
    gifMO.previewImage = [[GifManagedObjectImage alloc] initWithPreviewImage:item context:context];
    return gifMO;
}

@end

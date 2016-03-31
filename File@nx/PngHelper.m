//
//  PngHelper.m
//  File@nx
//
//  Created by juliano on 3/31/16.
//  Copyright © 2016 juliano. All rights reserved.
//

#import "PngHelper.h"
//#include <stdio.h>
//#include <fcntl.h>
//#include <unistd.h>
//#include <arpa/inet.h>
//#include <err.h>

@implementation PngHelper

+(CGSize)getPNGSize:(NSString *)filePath
{
    if (!filePath.length) {
        return CGSizeZero;
    }
    int fd;
    uint32_t height = 0, width = 0;
        if ((fd = open(filePath.UTF8String, O_RDONLY)) == -1)
        {
            printf("Error occurs when opening file");
            return CGSizeZero;
        }
        if (lseek(fd, 16, SEEK_SET) == -1)
        {
            return CGSizeZero;
        }
        if (read(fd, &width, 4) < 1)
        {
            return CGSizeZero;
        }
        if (read(fd, &height, 4) < 1)
        {
            return CGSizeZero;
        }
        if (close(fd) == -1)
        {
            printf("Error occurs when closing file");
//            return CGSizeZero;
        }

    return CGSizeMake(htonl(width), htonl(height));
}

@end

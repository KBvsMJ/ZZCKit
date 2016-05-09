//
//  NSFileManager+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSFileManager+SSToolkitAdditions.h"

@implementation NSFileManager (SSToolkitAdditions)



+ (NSString *)ss_applicationPath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)ss_documentPath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)ss_libPreferencePath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
}

+ (NSString *)ss_libCachePath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)ss_tmpPath {
    
    return NSTemporaryDirectory();
}






#pragma mark - 文件操作（文件或者目录是否存在，新建目录，新建文件，剪切，复制，删除）


//判断目录或者文件是否存在
+ (BOOL)ss_isExistsAtPath:(NSString *)path {
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


//创建目录(如果目录不存在，则创建)
+ (void)ss_createDirectoryAtPath:(NSString *)path {
    
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

//创建文件(如果文件不存在，则创建)
+ (void)ss_createFileAtPath:(NSString *)path {
    
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] ) {
        
        [[NSFileManager defaultManager] createFileAtPath:path
                                                contents:nil
                                              attributes:nil];
    }
}


//根据文件路径获取文件名(包括文件后缀)
+ (NSString *)ss_getFileNameFromFilePath:(NSString *)filePath {
    
    return [filePath lastPathComponent];
}

//根据文件路径获取文件后缀
+ (NSString *)ss_getFileExtensionFromFilePath:(NSString *)filePath {
    
    return [filePath pathExtension];
}

//根据文件路径获取目录
+ (NSString *)ss_getDocumentFromFilePath:(NSString *)filePath {
    
    return [filePath stringByDeletingLastPathComponent];
}



//剪切某个目录下的某个文件到另一个目录下，
+ (BOOL)moveFile:(NSString *)fileName atPath:(NSString *)path
      toDestFile:(NSString *)destFileName atDestPath:(NSString *)destPath
           Error:(NSError **)err {
    
    [NSFileManager ss_createDirectoryAtPath:destPath];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSString *destFilePath = [destPath stringByAppendingPathComponent:destFileName];
    return [[NSFileManager defaultManager] moveItemAtPath:filePath
                                                   toPath:destFilePath
                                                    error:err];
}


//复制某个目录下的某个文件到另一个目录下，
+ (BOOL)ss_copyFile:(NSString *)fileName atPath:(NSString *)path
         toDestFile:(NSString *)destFileName atDestPath:(NSString *)destPath
              Error:(NSError **)err {
    [NSFileManager ss_createDirectoryAtPath:destPath];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSString *destFilePath = [destPath stringByAppendingPathComponent:destFileName];
    
    return [[NSFileManager defaultManager] copyItemAtPath:filePath
                                                   toPath:destFilePath
                                                    error:err];
}


//删除某个目录下的某个文件
+ (BOOL)ss_deleteFile:(NSString *)fileName atPath:(NSString *)path Error:(NSError **)err {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    BOOL success = [fileManager removeItemAtPath:filePath error:err];
    return success;
}





#pragma mark - 文件读写

+ (NSData *)ss_readFile:(NSString *)fileName atPath:(NSString *)path {
    
    NSData *data = nil;
    if (fileName && path) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:filePath]) {
            data = [NSData dataWithContentsOfFile:filePath];
        }
    }
    return data;
}

//写入文件(先清除原有的文件内容，再写入新的文件内容)
+ (void)ss_writeData:(NSData *)data FileName:(NSString *)name atPath:(NSString *)path {
    
    if (data && name && path) {
        NSString *filePath = [path stringByAppendingPathComponent:name];
        
        //如果不存在，则创建
        [NSFileManager ss_createFileAtPath:filePath];
        
        //打开文件并写入数据
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [fileHandle truncateFileAtOffset:0];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    }
}

//追加写入文件
+ (void)ss_appendWriteData:(NSData *)data FileName:(NSString *)name atPath:(NSString *)path {
    
    if (data && name && path) {
        
        NSString *filePath = [path stringByAppendingPathComponent:name];
        
        //如果不存在，则创建
        [NSFileManager ss_createFileAtPath:filePath];
        
        //打开文件并写入数据
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    }
}



@end

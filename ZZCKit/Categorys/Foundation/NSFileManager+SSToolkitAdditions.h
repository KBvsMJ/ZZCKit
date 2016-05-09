//
//  NSFileManager+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (SSToolkitAdditions)

/*
 *程序目录(Applications目录，即AppName.app 目录)，
 *应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，
 *所以您在运行时不能对这个目录中的内容进行修改，否则可能会使应用程序无法启动。
 */
+ (NSString *)ss_applicationPath;

/*
 *文档目录(Documents目录)
 *苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 */
+ (NSString *)ss_documentPath;


/*
 *Preferences 目录包含应用程序的偏好设置文件
 *您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
 */

+ (NSString *)ss_libPreferencePath;

/*
 *Caches 目录
 *用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。系统永远不会删除这里的文件，ITUNES会删除
 */
+ (NSString *)ss_libCachePath;


/*
 *tmp 目录
 *这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。
 */
+ (NSString *)ss_tmpPath;




#pragma mark 文件操作（文件或者目录是否存在，新建目录，新建文件，剪切，复制，删除）


//判断目录或者文件是否存在
+ (BOOL)ss_isExistsAtPath:(NSString *)path;

//创建目录(如果目录不存在，则创建)
+ (void)ss_createDirectoryAtPath:(NSString *)path;

//创建文件(如果文件不存在，则创建)
+ (void)ss_createFileAtPath:(NSString *)path;


//根据文件路径获取文件名(包括文件后缀)
+ (NSString *)ss_getFileNameFromFilePath:(NSString *)filePath;

//根据文件路径获取文件后缀
+ (NSString *)ss_getFileExtensionFromFilePath:(NSString *)filePath;

//根据文件路径获取目录
+ (NSString *)ss_getDocumentFromFilePath:(NSString *)filePath;


//剪切某个目录下的某个文件到另一个目录下，
+ (BOOL)moveFile:(NSString *)fileName atPath:(NSString *)path
      toDestFile:(NSString *)destFileName atDestPath:(NSString *)destPath
           Error:(NSError **)err;

//复制某个目录下的某个文件到另一个目录下，
+ (BOOL)ss_copyFile:(NSString *)fileName atPath:(NSString *)path
         toDestFile:(NSString *)destFileName atDestPath:(NSString *)destPath
              Error:(NSError **)err;

//删除某个目录下的某个文件
+ (BOOL)ss_deleteFile:(NSString *)fileName atPath:(NSString *)path Error:(NSError **)err;



#pragma mark - 文件读写
//读文件
+ (NSData *)ss_readFile:(NSString *)fileName atPath:(NSString *)path;

//写入文件(先清除原有的文件内容，再写入新的文件内容)
+ (void)ss_writeData:(NSData *)data FileName:(NSString *)name atPath:(NSString *)path;

//追加写入文件
+ (void)ss_appendWriteData:(NSData *)data FileName:(NSString *)name atPath:(NSString *)path;


@end

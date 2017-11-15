//
//  YSTFileManageTool.h
//  工具类
//
//  Created by 易商通 on 2017/8/8.
//  Copyright © 2017年 张楚雄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//加密工具类
#import "YSTCommonEncrypt.h"

/**
 文件目录类型

 - YSTFileTypeDocument: 常用目录，iTunes同步该应用时候会同步此文件夹的内容，适合存储重要数据。
 - YSTFileTypeCaches: 不会同步此文件夹，适合存储体积大，不需要备份的非重要数据。
 - YSTFileTypeTmp: iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件夹，所以此目录适合保存应用中的一些临时文件，用完就删掉。
 */
typedef NS_ENUM(NSInteger ,YSTFileType){
    
    YSTFileTypeDocument = 0,
    
    YSTFileTypeCaches ,
    
    YSTFileTypeTmp,

};





@interface YSTFileManageTool : NSObject

+ (instancetype _Nullable )shareManager;


/**
 创建文件路径

 @param fileName 文件名
 @param subfolder 子文件夹
 @param type 文件父目录
 @return 文件的绝对路径
 */
- (NSString *_Nullable)creatFilePathWithFileName:(NSString *_Nullable)fileName withSubfolder:(NSString *_Nullable)subfolder withType:(YSTFileType)type;


/**
 保存文件
 
 @param file 文件（支持Data和image）
 @param filePath 文件的绝对路径
 @return 结果
 */
- (BOOL)saveToLocalFolderWithFile:(id _Nullable )file WithFilePath:(NSString *_Nullable)filePath;



/**
 文件写入

 @param content 支持字符串数组和字典
 @param path 文件路径
 @return 结果
 */
- (BOOL)writeToFileWithContent:(id _Nullable )content withPath:(NSString *_Nullable)path;


/**
 读取文件中的字符串信息

 @param path 文件路径
 @return 字符串
 */
- (NSString *_Nullable)readToFileWithContentWithFilePath:(NSString *_Nullable)path;



/**
 删除文件

 @param path 文件路径
 @return 结果
 */
-(BOOL)deleteFileWithFilePath:(NSString *_Nullable)path;



/**
 获取文件夹大小

 @param path 文件夹的路径
 @return 大小（B）
 */
//无符号长整型，可以使用long long来修饰一个整型，但是long long不能修饰double
-(unsigned long long)subfolderSizeAtPath:(NSString *_Nullable)path;


/**
 获取单个文件的大小

 @param path 文件路径
 @return 大小（B）
 */
-(unsigned long long)fileSizeAtPath:(NSString *_Nullable)path;

/**
 NSUserDefaults数据存储
 
 @param value value
 @param key key
 */
+ (void)NSUSERDEFAULTS_SetValue:(NSString *_Nullable)value forKey:(NSString *_Nullable)key;


/**
 NSUserDefaults数据获取
 
 @param key key
 @return value
 */
+ (NSString *_Nullable)NSUSERDEFAULTS_ObjectForKey:(NSString *_Nullable)key;


/**
 md5加密

 @param str         加密前字符串
 @return md5        加密后的字符串
 */
+(NSString *_Nullable)md5String:(NSString *_Nullable)str;

/**
 base64加密

 @param str         加密前字符串
 @return base64     加密后字符串
 */
+(NSString *_Nullable)base64EnodedString:(NSString *_Nullable)str;
//空格

+(NSString *_Nullable)dateSpaceAndEntr:(NSString *_Nullable)str;
/**
 业务参数升序加密（传字符串）

 @param paramter    需要验签的字符串
 @return            验签加密后的字符串
 */
+(NSString *_Nullable)encryptUrlWithPara:(NSString *_Nullable)paramter;

/**
 业务参数升序加密（传字典）

 @param paramter    需要验签的字典
 @return            验签加密后的字符串

 */
+(NSString *_Nullable)encryptUrlWithParaDic:(NSDictionary *_Nullable)paramter;



@end

//
//  YSTFileManageTool.m
//  工具类
//
//  Created by 易商通 on 2017/8/8.
//  Copyright © 2017年 张楚雄. All rights reserved.
//

#import "YSTFileManageTool.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface YSTFileManageTool ()

@property(nonatomic,strong)NSFileManager *fileManager;

@end

@implementation YSTFileManageTool

-(NSFileManager *)fileManager{

    if (!self.fileManager) {
        
        self.fileManager = [NSFileManager defaultManager];
        
    }
    
    return self.fileManager;

}

+ (instancetype _Nullable )shareManager{

    static YSTFileManageTool *manager = nil;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
    
        manager = [[YSTFileManageTool alloc]init];
    
    });
    
    return manager;
}

- (NSString *_Nullable)creatFilePathWithFileName:(NSString *_Nullable)fileName withSubfolder:(NSString *_Nullable)subfolder withType:(YSTFileType)type{

    NSString *path,*subfolderPath,*filePath;
    
    switch (type) {
        case YSTFileTypeDocument:
            path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            break;
        case YSTFileTypeCaches:
            path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            break;
        case YSTFileTypeTmp:
            path = NSTemporaryDirectory();
            break;
        default:
            break;
    }
    
    if (subfolder.length > 0) {
      
        subfolderPath = [path stringByAppendingPathComponent:subfolder];
      
        BOOL isDir = YES;
      
        if (![self.fileManager fileExistsAtPath:subfolderPath isDirectory:&isDir]) {
        
            [self.fileManager createDirectoryAtPath:subfolderPath withIntermediateDirectories:YES attributes:nil error:nil];
       
        }
    
    }else{
     
        subfolderPath = path;
    
    }
    
    filePath = [subfolderPath stringByAppendingPathComponent:fileName];
    
    NSLog( @"file path:%@",filePath);
    
    return filePath;
}

- (BOOL)saveToLocalFolderWithFile:(id _Nullable )file WithFilePath:(NSString *_Nullable)filePath{

    if ([self.fileManager fileExistsAtPath:filePath]) {
        
        return NO;
    }
    
    NSData *fileData;
   
    if ([file isKindOfClass:[NSData class]]) {
    
        fileData = file;
  
    }else if ([file isKindOfClass:[UIImage class]]){
    
        fileData = UIImageJPEGRepresentation(file, 1.0);
   
    }else{
    
        return NO;
    }
   
    return [fileData writeToFile:filePath atomically:YES];
}

- (BOOL)writeToFileWithContent:(id _Nullable )content withPath:(NSString *_Nullable)path{

    //文件的读取可以直接使用NSArray，NSDictionary和NSString的相应方法
    if ([content isKindOfClass:[NSString class]]) {
        return [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        return [content writeToFile:path atomically:YES];
    }
}

- (NSString *_Nullable)readToFileWithContentWithFilePath:(NSString *_Nullable)path{

    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

}

-(BOOL)deleteFileWithFilePath:(NSString *_Nullable)path{
    
    return [self.fileManager removeItemAtPath:path error:nil];
    
}

-(unsigned long long)fileSizeAtPath:(NSString *_Nullable)path{
    
    if ([self.fileManager fileExistsAtPath:path]) {
        
        unsigned long long fileSize = [[self.fileManager attributesOfItemAtPath:path error:nil] fileSize];
        
        return fileSize;
        }else{
        
        return 0;
    }
}

-(unsigned long long)subfolderSizeAtPath:(NSString *_Nullable)path{
    
    if ([self.fileManager fileExistsAtPath:path
        ]) {
        //递归的方式获取子项列表
        NSEnumerator *chileFileEnumerator = [[self.fileManager subpathsAtPath:path]objectEnumerator];
        unsigned long long subfolderSize = 0;
        
        NSString *fileName = @"";
        
        while ((fileName = [chileFileEnumerator nextObject]) != nil) {
            NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            subfolderSize +=[self fileSizeAtPath:fileAbsolutePath];
        }
        return subfolderSize;
        
    }else{
        
        return 0;
    }
    


}

+ (void)NSUSERDEFAULTS_SetValue:(NSString *_Nullable)value forKey:(NSString *_Nullable)key{

    //存储前加密
    NSString *encryptValue = [YSTCommonEncrypt base64StringFromText:value];
    
    NSString *encryptkey = [YSTCommonEncrypt base64StringFromText:key];
    
    [[NSUserDefaults standardUserDefaults]setObject:encryptValue forKey:encryptkey];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

+ (NSString *_Nullable)NSUSERDEFAULTS_ObjectForKey:(NSString *_Nullable)key{

    NSString *encryptkey = [YSTCommonEncrypt base64StringFromText:key];
    
    NSString *encryptValue = [[NSUserDefaults standardUserDefaults]objectForKey:encryptkey];
    
    NSString *DecryptValue = [YSTCommonEncrypt textFromBase64String:encryptValue];
    
    return DecryptValue;
    
}

+(NSString *)md5String:(NSString *)str
{
    if (str) {
        const char *cStr = [str UTF8String];
        unsigned char digest[16];
        unsigned int x=(int)strlen(cStr) ;
        CC_MD5( cStr, x, digest );
        // This is the md5 call
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", digest[i]];
        
        return  output;
    }else
    {
        return nil;
    }
    
}
+(NSString *)base64EnodedString:(NSString *)str
{
    if (str) {
        NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSString * database64 = [data base64EncodedStringWithOptions:0];
        return database64;
    }else
    {
        return nil;
    }
}
+(NSString *)dateSpaceAndEntr:(NSString *)str
{
    NSString * deleES = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"" ];
    NSString * deleSp = [deleES stringByReplacingOccurrencesOfString:@" " withString:@"" ];
    return deleSp;
}
//业务参数升序加密（传字符串）
+(NSString *)encryptUrlWithPara:(NSString *)paramter{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    if (paramter.length > 0) {
        NSArray * arrByP = [paramter componentsSeparatedByString:@"&"];
        for (NSString * paraS in arrByP) {
            
            if (paraS && paraS.length > 0) {
                NSArray * keyValueArr = [paraS componentsSeparatedByString:@"="];
                [dic setObject:keyValueArr[1] forKey:keyValueArr[0]];
            }
        }
    }
    
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setObject:@"I" forKey:@"client_type"];
    //    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    //    NSString * timeString = [NSString stringWithFormat:@"%0.0lf",time];
    //    [mutableDic setObject:timeString forKey:@"timestamp"];
    NSMutableArray * dicAllKeys = [NSMutableArray arrayWithArray:[mutableDic allKeys]];
    
    [dicAllKeys sortUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString * paramterStr = [NSMutableString stringWithCapacity:1];
    
    for (int i = 0; i < dicAllKeys.count; i ++) {
        NSString * key = dicAllKeys[i];
        if (i == 0) {
            [paramterStr appendFormat:@"%@=%@",key,mutableDic[key]];
        }else{
            [paramterStr appendFormat:@"&%@=%@",key,mutableDic[key]];
        }
    }
    NSString * md5Str = [self md5String:paramterStr];
    NSString * newMd5Str = [NSString stringWithFormat:@"%@%@%@",md5Str,@"PHPF",@"I"];
    NSString * base64Str = [self base64EnodedString:newMd5Str];
    
    
    return base64Str;
    
}

+(NSString *_Nullable)encryptUrlWithParaDic:(NSDictionary *_Nullable)paramter{


    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionaryWithDictionary:paramter];
    [mutableDic setObject:@"I" forKey:@"client_type"];
//    NSMutableArray * dicAllKeys = [NSMutableArray arrayWithArray:[mutableDic allKeys]];
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < dicAllKeys.count; i ++) {
//        NSString * key = dicAllKeys[i];
//            [array addObject:key];
//    }
    
    NSMutableArray * dicAllKeys2 = [NSMutableArray arrayWithArray:[mutableDic allKeys]];
    
    [dicAllKeys2 sortUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString * paramterStr = [NSMutableString stringWithCapacity:1];
    
    for (int i = 0; i < dicAllKeys2.count; i ++) {
        NSString * key = dicAllKeys2[i];
        if (i == 0) {
            [paramterStr appendFormat:@"%@=%@",key,mutableDic[key]];
        }else{
            [paramterStr appendFormat:@"&%@=%@",key,mutableDic[key]];
        }
    }
    NSString * md5Str = [self md5String:paramterStr];

    NSString * newMd5Str = [NSString stringWithFormat:@"%@%@%@",md5Str,@"KHZG",@"I"];

    NSString * base64Str = [self base64EnodedString:newMd5Str];
    return base64Str;

}



@end

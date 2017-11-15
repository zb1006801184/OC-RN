//
//  ShopPhotoViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ShopPhotoViewController.h"
//****相机******
#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>
#import "HXPhotoViewController.h"

#define tagIndex 1000
#define tagBtnIndex 2000
#define imageTag 3000
#define scrollHight  200

@interface ShopPhotoViewController ()
<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIScrollViewDelegate,HXPhotoViewControllerDelegate>{
    //拖动图片
    BOOL contain;
    CGPoint startPoint;
    CGPoint buttonP;
    CGPoint originPoint;
    
    NSInteger count;
    CGFloat imageHeight;
}

@property(nonatomic,strong)UIScrollView *scrollImage;
@property(nonatomic,strong)UIView *imageView;
//@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)UILabel *xianLabel;

//*****
@property(nonatomic)NSInteger imagecount; //个数判断cell高度
@property(nonatomic,strong)UIImageView *addImage;   //加字图片
@property(nonatomic)int imageCount;
@property(nonatomic,strong)NSMutableArray *arrayDetectionCount; //用于检测是否上传成功
@property(nonatomic,strong)UIImage *image;                  //接收选择后的图片
//@property(nonatomic,strong)NSMutableArray *arrayImageID;    //存储imageID
@property(nonatomic,strong)UIView *headImageView;           //存放scoll上图片view

@property(nonatomic,strong)NSMutableArray *arrayScrollArray;    //存储上边scoll图用于每次清除
@property(nonatomic,strong)UIImageView *scrooImageView; //上边显示的
@property(nonatomic,strong)UILabel *label;      //图片个数
@property(nonatomic,strong)UIButton *btn;
@property (strong, nonatomic) HXPhotoManager *manager;

//拖动图片
@property (strong, nonatomic) NSMutableArray * buttons;
@property(nonatomic,strong)NSMutableArray *itemArray;
@property(nonatomic,strong)NSMutableArray *imageArray;  //存储选择的图片
@property(nonatomic,strong)NSMutableArray *imagetempArray;  //临时先存 接口太慢
@property(nonatomic,strong)NSMutableArray *dragDataArray;   //存储btn字符串用于记下表
@property(nonatomic,strong)NSMutableArray *imageArrayID;    //存图片id;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property(nonatomic,strong)NSMutableArray *valueIdArray;
@end

@implementation ShopPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:self.titleStr isBack:YES];
    if (SCREEN_WIDTH < 375) {
        imageHeight = 60;
    }
    else if (SCREEN_WIDTH == 375){
        imageHeight = 70;
    }
    else{
        imageHeight = 80;
    }
    self.itemArray = [[NSMutableArray alloc]init];
    self.arrayScrollArray = [NSMutableArray array];
    self.arrayDetectionCount = [NSMutableArray array];
    self.imageArray = [NSMutableArray array];
    self.dragDataArray = [[NSMutableArray alloc]init];
    self.imageArrayID = [NSMutableArray array];// 存id 仿照drag数组
    
    self.valueArray = [[NSMutableArray alloc]initWithArray:self.valueImageArray];
    self.valueIdArray = [[NSMutableArray alloc]initWithArray:self.imageID];
    
    [self creatNav];
    [self creatView];
    
    // Do any additional setup after loading the view.
}
-(void)creatNav{
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(SCREEN_WIDTH-64, 0, 64, 44)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(CompleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:rightButton];
    
}
-(void)clickLeftButton{
    if (self.block !=nil) {
        self.block(self.valueArray,self.valueIdArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
//保存
-(void)CompleteAction{
    
    NSLog(@"保存");
    NSLog(@"%@====%@",self.imageArrayID,self.imageArray);
    
    if (self.block !=nil) {
        self.block(self.imageArray,self.imageArrayID);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatView{
    
    self.scrollImage = [[UIScrollView alloc]init];
    self.scrollImage.frame = (CGRect){0,64,self.view.frame.size.width,scrollHight};
    self.scrollImage.contentSize = CGSizeMake(self.view.frame.size.width*self.itemArray.count,scrollHight-100);
    self.scrollImage.pagingEnabled = YES;//整页滚动
    self.scrollImage.showsHorizontalScrollIndicator = NO;
    self.scrollImage.showsVerticalScrollIndicator = NO;
    self.scrollImage.bounces= NO;
    self.scrollImage.delegate = self;
    [self.view addSubview:self.scrollImage];
    
    
    self.label = [[UILabel alloc]init];
    self.label.frame = (CGRect){self.scrollImage.frame.size.width/2-20,self.scrollImage.frame.size.height-20,40,20};
    self.label.textColor = [UIColor whiteColor];
    self.label.hidden = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = RGBA_COLOR(0, 0, 0, .4);
    [self.view insertSubview:self.label atIndex:999];
    
    
    //下边的
    self.imageView = [[UIView alloc]init];
    self.imageView.frame = (CGRect){0,CGRectGetMaxY(self.scrollImage.frame)+10,self.view.frame.size.width,150};
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = (CGRect){20,10,150,20};
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor grayColor];
    label.text = @"长按图片可拖动排序";
    [self.imageView addSubview:label];
    
    
    self.xianLabel = [[UILabel alloc]init];
    self.xianLabel.frame = (CGRect){CGRectGetMinX(label.frame),CGRectGetMaxY(label.frame)+10,self.imageView.frame.size.width-40,1};
    _xianLabel.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    [self.imageView addSubview:_xianLabel];
    
    self.addImage = [[UIImageView alloc]init];
    self.addImage.frame = (CGRect){20,CGRectGetMaxY(self.xianLabel.frame)+20,imageHeight,imageHeight};
    self.addImage.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer *chooseImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage:)];
    chooseImageTap.delegate = self;
    [self.addImage addGestureRecognizer:chooseImageTap];
    [self.imageView addSubview:self.addImage];
    [self.addImage setImage:[UIImage imageNamed:@"addPicture"]];
    
    if (self.valueImageArray.count == 0 ||self.imageID.count == 0) {
        
    }else{
        for (int i =0; i<self.imageID.count; i++) {
            [self.imageArrayID addObject:self.imageID[i]];
        }
        self.imageArray = self.valueImageArray;
        if (self.imageArray.count != 0 && self.imageArrayID.count != 0) {
            [self creatImageForArray];
        }
    }
}

#pragma mark Pictuire
//图片

-(void)chooseImage:(UITapGestureRecognizer *)sender{
    
    UIActionSheet *menu = [[UIActionSheet alloc]
                           initWithTitle: @""
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                           otherButtonTitles:@"图库相册",@"拍照", nil];
    [menu showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        [self fromPhotoLibrary];
        
    }else if(buttonIndex == 1){
        [self photoView:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex == 2){
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)photoView:(UIImagePickerControllerSourceType )sourceType{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    //  picker.allowsEditing = YES;//开启的话下面选择后要用这个UIImagePickerControllerEditedImage
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

-(void)fromPhotoLibrary{
    
    //    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    //        self.popoverController = popover;
    //        [self.popoverController presentPopoverFromRect:CGRectMake(0, 0, 600, 800) inView:self.viewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //    }];
    
    
    self.imageCount = (int)self.dragDataArray.count;
    
    _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    _manager.videoMaxNum = 0;
    //    self.camera.on = YES;
    self.manager.photoMaxNum = 4-self.imageArray.count;//照片最大数
    self.manager.videoMaxNum = 0;
    self.manager.rowCount = 4;
    HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
    vc.delegate = self;
    vc.manager = self.manager;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    
}
- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original
{
//    NSString *total = [NSString stringWithFormat:@"%ld个",allList.count];
//    NSString *photis = [NSString stringWithFormat:@"%ld张",photos.count];
//    NSString *video = [NSString stringWithFormat:@"%ld个",videos.count];
    //    self.original.text = original ? @"YES" : @"NO";
    NSLog(@"all - %@",allList);
    NSLog(@"photo - %@",photos);
    self.arrayDetectionCount = [NSMutableArray array];
    self.imagetempArray = [NSMutableArray array];
    count = 0;
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    [ALToastView toastInView:self.view withText:@"上传图片中"];
    [photos enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size = PHImageManagerMaximumSize; // 通过传入 size 的大小来控制图片的质量
        [HXPhotoTools FetchPhotoForPHAsset:model.asset Size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
            NSLog(@"%@",image);
         
            _image = image;

            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            //            [self saveImage:_image withName:fileName];
            [self saveImage:_image withName:fileName];
            
        }];
        if (model.type == HXPhotoModelMediaTypeCameraPhoto){
            
        }
        
    }];
    
    
}
#pragma mark - 图片上传 - 相册
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage,1);
    
    float m = [imageData length]/1024.0;
    
    if (m>5*1024) {
        imageData = UIImageJPEGRepresentation(currentImage, 1/22);
    }
    if (m>4*1024) {
        imageData = UIImageJPEGRepresentation(currentImage, 1/20);
    }
    if (m>3*1024) {
        imageData = UIImageJPEGRepresentation(currentImage, 1/16);
    }
    if (m>2*1024) {
        imageData = UIImageJPEGRepresentation(currentImage, 1/12);
    }
    if (m>1024) {
        imageData = UIImageJPEGRepresentation(currentImage, 1/8);
    }
    if (m>0.5*1024) {
        imageData = UIImageJPEGRepresentation(currentImage, 1/4);
    }
    if (m>0.2*1024) {
        imageData = UIImageJPEGRepresentation(currentImage, 1/2);
    }
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:YES];
    
    [self.imagetempArray addObject:currentImage];
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/plain",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:JQXHttp_TableAddPhonePic parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *imageData =UIImageJPEGRepresentation(_image,1);
        
        
        float m = [imageData length]/1024.0;
        
        if (m>5*1024) {
            imageData = UIImageJPEGRepresentation(_image, 1/23);
        }
        if (m>4*1024) {
            imageData = UIImageJPEGRepresentation(_image, 1/20);
        }
        if (m>3*1024) {
            imageData = UIImageJPEGRepresentation(_image, 1/16);
        }
        if (m>2*1024) {
            imageData = UIImageJPEGRepresentation(_image, 1/12);
        }
        if (m>1024) {
            imageData = UIImageJPEGRepresentation(_image, 1/8);
        }
        if (m>0.5*1024) {
            imageData = UIImageJPEGRepresentation(_image, 1/4);
        }
        if (m>0.2*1024) {
            imageData = UIImageJPEGRepresentation(_image, 1/2);
        }
        
        
        //        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"image" //参数
                                fileName:fileName
                                mimeType:@"image/png"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] intValue] ==200) {
            count++;
            //            [self.imageArray addObject:currentImage];
            [self.imageArrayID addObject:responseObject[@"data"]];
            [self.imageArray addObject:responseObject[@"data"]];
            [self.arrayDetectionCount addObject:@"成功"];
            NSLog(@"%@",self.imageArray);
            NSLog(@"%@",self.imageArrayID);
            
            if (self.imagetempArray.count == count) {
                for (int i = 0; i<self.imagetempArray.count; i++) {
                    UIImage *image = self.imagetempArray[i];
                    [self.imageArray addObject:image];
                    
                }
                [self creatImageForArray];
                
            }
        }
        [JHHJView hideLoading];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);

        [JHHJView hideLoading];
        
    }];
    
    
    
    
}




//选择照相机完成后
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    self.arrayDetectionCount = [NSMutableArray array];
    //    [self.navigationController.view showActivityViewWithLabel:@"上传图片.."];
    //UIImagePickerControllerEditedImage
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageOrientation imageOrientation=image.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
 
    //JQXHttp_TableAddPhonePic
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/plain",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:JQXHttp_TableAddPhonePic parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image,1);
        
        float m = [imageData length]/1024.0;
        
        if (m>5*1024) {
            imageData = UIImageJPEGRepresentation(image, 1/22);
        }
        if (m>4*1024) {
            imageData = UIImageJPEGRepresentation(image, 1/20);
        }
        if (m>3*1024) {
            imageData = UIImageJPEGRepresentation(image, 1/16);
        }
        if (m>2*1024) {
            imageData = UIImageJPEGRepresentation(image, 1/12);
        }
        if (m>1024) {
            imageData = UIImageJPEGRepresentation(image, 1/8);
        }
        if (m>0.5*1024) {
            imageData = UIImageJPEGRepresentation(image, 1/4);
        }
        if (m>0.2*1024) {
            imageData = UIImageJPEGRepresentation(image, 1/2);
        }

        [formData appendPartWithFileData:imageData
                                    name:@"image" //参数
                                fileName:fileName
                                mimeType:@"image/png"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] intValue] ==200) {
            [self.imageArray addObject:image];
            [self.imageArrayID addObject:responseObject[@"data"]];
            [self.arrayDetectionCount addObject:@"成功"];
            [self creatImageForArray];
            [ALToastView toastInView:self.view withText:@"上传成功"];
        }
        [JHHJView hideLoading];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //        NSLog(@"%@",error);
        [JHHJView hideLoading];
        
    }];

}


-(void)imageVlueBlock:(imageBlock)block{
    self.block = block;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint  offset = scrollView.contentOffset;//偏移量
    if (offset.x < 0 ) {
        scrollView.contentOffset = CGPointMake(0, offset.y);
    }
    if (offset.x > scrollView.frame.size.width*(self.itemArray.count -1)) {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width*(self.itemArray.count-1) , offset.y);
    }
    NSUInteger  index = round(offset.x/scrollView.frame.size.width);
    //设置分页控件中处于被激活的提示符的下标
    self.label.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.itemArray.count];
    //NSLog(@"(%f,%f)",offset.x,offset.y);
}

-(void)creatImageForArray{
    
    if (self.imageArray.count ==0) {
        
        self.label.hidden = YES;
    }else{
        self.label.hidden = NO;
    }
    NSMutableArray *array = [NSMutableArray array];
    array = self.imageArrayID;
    
    for (UIButton *btn in self.itemArray) {
        [btn removeFromSuperview];
    }
    self.itemArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.dragDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSLog(@"%@",array);
    for (int i =0; i<array.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = (CGRect){20+i*(imageHeight+20),CGRectGetMaxY(self.xianLabel.frame)+20,imageHeight,imageHeight};
        btn.tag = i+ tagIndex;
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:array[i] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
        //        [btn setImage:array[i] forState:UIControlStateNormal];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [btn addGestureRecognizer:longGesture];
        
        UIImageView *image = [[UIImageView alloc]init];
        image.frame = (CGRect){0,0,btn.frame.size.width,btn.frame.size.height};
        [image sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [btn addSubview:image];
        
        
        [self.imageView addSubview:btn];
        [self.itemArray addObject:btn];
        [self.dragDataArray addObject:[NSString stringWithFormat:@"%i",i+1]];
    }
    NSLog(@"%@",self.itemArray);
    
    self.addImage.frame = (CGRect){20+array.count*(imageHeight+20),self.addImage.frame.origin.y,self.addImage.frame.size.width,self.addImage.frame.size.height};
    if (array.count >= 4) {
        self.addImage.hidden = YES;
    }else{
        self.addImage.hidden = NO;
    }
    
    self.scrollImage.contentSize = CGSizeMake(self.view.frame.size.width*self.itemArray.count,scrollHight-100);
    self.label.text = [NSString stringWithFormat:@"1/%ld",self.itemArray.count];
    [self headImageAction];
}
//创建上面的headimage
-(void)headImageAction{
    [self.headImageView removeFromSuperview];
    
    
    for (UIImageView *im in self.arrayScrollArray) {
        [im removeFromSuperview];
        
    }
    for (int j =0; j<self.imageArrayID.count; j++) {
        self.headImageView = [[UIView alloc]init];
        self.headImageView.frame =  (CGRect){j*SCREEN_WIDTH,0,SCREEN_WIDTH,CGRectGetHeight(self.scrollImage.frame)};
        self.headImageView.backgroundColor = [UIColor whiteColor];
        [self.scrollImage addSubview:self.headImageView];
        
        UIImageView *image = [[UIImageView alloc]init];
        image.frame = (CGRect){30,0,SCREEN_WIDTH-60,CGRectGetHeight(self.headImageView.frame)};
        [image sd_setImageWithURL:[NSURL URLWithString:self.imageArrayID[j]] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
        image.tag = j+imageTag;
        NSLog(@"self.imageArray.tag%ld",(long)image.tag);
        NSLog(@"self.imageArray====%@",self.imageArray[j]);
        
        image.userInteractionEnabled = YES;
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.headImageView addSubview:image];
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = (CGRect){self.scrollImage.frame.size.width-40,15,25,25};
        btn.tag = j+tagBtnIndex;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headImageView addSubview:btn];
        
        [self.arrayScrollArray addObject:self.headImageView];
        
    }
    CGPoint  offset = self.scrollImage.contentOffset;
    offset.x = 0;
    self.scrollImage.contentOffset = offset;
    
}
-(void)changeheadImage{
    
}
//删除图片
-(void)deleteImageAction:(UIButton *)sender{
    //
    NSLog(@"%ld",sender.tag);
    
    [self.imageArray removeObjectAtIndex:sender.tag-tagBtnIndex];
    NSLog(@"%@",self.imageArray);
    [self.imageArrayID removeObjectAtIndex:sender.tag-tagBtnIndex];
    [self.dragDataArray removeObjectAtIndex:sender.tag-tagBtnIndex];
    
    NSLog(@"移除后的个数%ld",self.itemArray.count);
    NSLog(@"%@=====%@",self.imageArray,self.imageArrayID);
    [self creatImageForArray];
    
    //if (self.headImageView) {
    
    
    //}
}
//*******拖动***

#pragma mark 拖拽排序
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    UIButton *btn = (UIButton *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        [UIView animateWithDuration:0.5 animations:^{
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        //NSLog(@"center = %@",NSStringFromCGPoint(btn.center));
        NSInteger index = [self indexOfPoint:btn.center withButton:btn];
        
        NSLog(@"%ld",index);
        
        if (index<0)
        {
            contain = NO;
        }
        else
        {
            
            [UIView animateWithDuration:0.5 animations:^{
                CGPoint temp = CGPointZero;
                UIButton *button = _itemArray[index];
                NSLog(@"当前tag为%ld",btn.tag);
                NSLog(@"要换的tag值为%ld",button.tag);
                
                
                temp = button.center;
                button.center = originPoint;
                btn.center = temp;
                originPoint = btn.center;
                contain = YES;
            }];
            
            NSLog(@"%ld-----%ld",btn.tag-tagIndex,index);
            [self changeArrayIndexWithPreIndex:btn.tag-tagIndex lastIndex:index];
            
            //////////////////////
            UIButton *firstbtn = (UIButton *) [self.imageView viewWithTag:btn.tag] ;
            UIButton *lastbtn = (UIButton *) [self.imageView viewWithTag:index+tagIndex] ;
            NSLog(@"移动得tag……%ld======要换的tag……%ld",firstbtn.tag,lastbtn.tag);
            
            NSInteger firstIndex = firstbtn.tag;
            NSInteger lastIndex = lastbtn.tag;
            
            lastbtn.tag = firstIndex;
            firstbtn.tag = lastIndex;
            NSLog(@"换完后first--%ld      last--%ld ",firstbtn.tag,lastbtn.tag);
        }
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.5 animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!contain)
            {
                btn.center = originPoint;
            }
            
        }];
        
        
    }
}
- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIButton *)btn
{
    for (NSInteger i = 0;i<_itemArray.count;i++)
    {
        UIButton *button = _itemArray[i];
        if (button != btn)
        {
            if (CGRectContainsPoint(button.frame, point))
            {
                return i;
            }
        }
    }
    return -1;
}
- (void)changeArrayIndexWithPreIndex:(NSInteger)preindex lastIndex:(NSInteger)lastIndex
{
    //接口之后 还要添加一行id的换位
    
    NSLog(@"按中图片%ld--------移动后位置%ld",preindex,lastIndex);
    
    NSLog(@"oldimageArrayID==========%@",self.imageArrayID);
    
    [_imageArray exchangeObjectAtIndex:preindex withObjectAtIndex:lastIndex];
    [_itemArray exchangeObjectAtIndex:preindex withObjectAtIndex:lastIndex];
    
    [self.imageArrayID exchangeObjectAtIndex:preindex withObjectAtIndex:lastIndex];
    
    //删除当前视图，重新加载
    [self headImageAction];
    
    CGRect rect = self.scrollImage.frame;
    rect.origin.x = lastIndex * self.scrollImage.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [self.scrollImage scrollRectToVisible:rect animated:YES];
    
    NSLog(@"lastIndex=%ld",(long)lastIndex);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

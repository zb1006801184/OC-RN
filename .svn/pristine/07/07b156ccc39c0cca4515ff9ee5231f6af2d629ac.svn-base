//
//  ChoosePhoController.m
//  testPhoto
//
//  Created by WHISPERS on 2017/7/25.
//  Copyright © 2017年 WHISPERS. All rights reserved.
//


#import "ChoosePhoController.h"
#import "ChoosePhotoCell.h"

#define HeightClearance 2
#define WidthClearance 2

@interface ChoosePhoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) UICollectionView *photoColl;
@property (nonatomic, assign) float photoWidth;
@property (nonatomic, assign) float photoHeight;
@property (nonatomic, assign) int maxNumber;
@property (nonatomic, assign) int showNumber;
@property (nonatomic, strong) UIScrollView *imageScroll;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation ChoosePhoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.photoArr = [NSMutableArray array];
}


- (void)sendStrFunc:(CGSize)size maxNumber:(int)maxNumber showNumber:(int)showNumber{
    _photoWidth = size.width;
    _photoHeight = size.height;
    _maxNumber = maxNumber;
    _showNumber = showNumber;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *photoColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _photoWidth, _photoHeight) collectionViewLayout:layout];
    photoColl.delegate = self;
    photoColl.dataSource = self;
    photoColl.backgroundColor = [UIColor whiteColor];
    [photoColl registerClass:[ChoosePhotoCell class] forCellWithReuseIdentifier:@"cell"];
    self.photoColl = photoColl;
    [self.view addSubview:photoColl];
    
    
    UIScrollView *imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageScroll.backgroundColor = [UIColor blackColor];
    imageScroll.pagingEnabled = YES;
    imageScroll.bounces = NO;
    imageScroll.delegate = self;
    self.imageScroll = imageScroll;
    imageScroll.userInteractionEnabled = YES;
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((SCREEN_WIDTH - 20) / 2, SCREEN_HEIGHT - 50, 20, 20);
    pageControl.currentPage = 0;
    pageControl.hidden = YES;
    pageControl.pageIndicatorTintColor = RGB_COLOR(70, 70, 70);
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl = pageControl;
    
    
    UITapGestureRecognizer *scrTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrTap:)];
    scrTap.numberOfTapsRequired = 1;
    scrTap.numberOfTouchesRequired = 1;
    [imageScroll addGestureRecognizer:scrTap];
    
}

#pragma mark ------ UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_photoArr.count == _maxNumber) {
        return _photoArr.count;
    }else{
        return _photoArr.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    ChoosePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.row == _photoArr.count) {
        cell.choosePhoto = [UIImage imageNamed:@"photo"];
        cell.deleBtn.hidden = YES;
    }else{
        cell.deleBtn.hidden = NO;
        cell.choosePhoto = _photoArr[indexPath.row];
        [cell setDelePhotoBlock:^(NSString *str) {
            [_photoArr removeObjectAtIndex:(int)indexPath.row];
            [self.dataArr removeObjectAtIndex:(int)indexPath.row];
            [_photoColl reloadData];
//            if (self.sendArrblock) {
//                self.sendArrblock(_photoArr);
//            }
        }];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_photoWidth / _showNumber - 1, _photoWidth / _showNumber - 1);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _photoArr.count) {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
        [action showInView:self.view];
    }else{
        
        [self bigImage];
        _imageScroll.contentSize = CGSizeMake(SCREEN_WIDTH * _photoArr.count, SCREEN_HEIGHT);
        _pageControl.numberOfPages = _photoArr.count;
        NSUInteger tag = indexPath.row;
        self.imageScroll.contentOffset = CGPointMake(SCREEN_WIDTH * tag, 0);
        [UIView animateWithDuration:0 animations:^{
            [[UIApplication sharedApplication].keyWindow addSubview:_imageScroll];
            [[UIApplication sharedApplication].keyWindow addSubview:_pageControl];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _pageControl.hidden = NO;
                self.imageScroll.alpha = 1;
            }];
        }];
        
    }
}


#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:^{
            //选择完成
        }];
    }else if (buttonIndex == 1){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:^{
            //选择完成
        }];
    }
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *formatInfo = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
    
    if ([formatInfo rangeOfString:@"JPG"].location == NSNotFound &&
        [formatInfo rangeOfString:@"PNG"].location == NSNotFound) {
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [_photoArr addObject:originalImage];
        
        [self uploadImage:originalImage];
        
        
    }
}

- (void)bigImage{
    for (int i = 0; i < _photoArr.count; i++) {
        UIView *bottonView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        bottonView.backgroundColor = [UIColor blackColor];
        [_imageScroll addSubview:bottonView];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - SCREEN_WIDTH) / 2, SCREEN_WIDTH, SCREEN_WIDTH)];
        imageView.image = _photoArr[i];
        imageView.userInteractionEnabled = YES;
        [bottonView addSubview:imageView];
    }
}

- (void)scrTap:(UITapGestureRecognizer *)tap{
    //    [UIView animateWithDuration:0.3 animations:^{
    [_imageScroll removeFromSuperview];
    [_pageControl removeFromSuperview];
    self.imageScroll.alpha = 0;
    _pageControl.hidden = YES;
    //    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    int number = offSetX / SCREEN_WIDTH;
    _pageControl.currentPage = number;
}
- (void)PhotoArray:(sendArrblock)block
{
     self.block = block;
}

- (void)uploadImage:(UIImage *)upimage
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:http_PhotoURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
//        NSData *data = UIImagePNGRepresentation(upimage);
        NSData * data = [self CompressedPictureWithImage:upimage];
        
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/png"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpImageLoading" object:nil userInfo:@{@"test":@"正在上传"}];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功 %@", responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpImageLoading" object:nil userInfo:@{@"test":@"结果"}];
        
        /*
         code = 200;
         count = 0;
         data = "https://ph-images.oss-cn-shenzhen.aliyuncs.com/merchant/app/image/20170727/20170727181025233761898.png";
         message = "\U56fe\U7247\U4e0a\U4f20\U6210\U529f";
         success = 1;
         */
        
        if([responseObject[@"code"]integerValue] == 200){
            NSString *dataStr = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            [self.dataArr addObject:dataStr];
            [_photoColl reloadData];
            
            if(self.block !=nil){
                self.block(self.dataArr);
                
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpImage" object:nil userInfo:@{@"test":@"上传成功"}];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpImage" object:nil userInfo:@{@"test":responseObject[@"message"]}];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败 %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpImageLoading" object:nil userInfo:@{@"test":@"结果"}];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"UpImage" object:nil userInfo:@{@"test":@"上传失败"}];
    }];
    
}

//图片压缩方法
-(NSData *)CompressedPictureWithImage:(UIImage *)image
{
    //压缩图片
    NSData * imageData = UIImageJPEGRepresentation(image, 1.0f);
    
    float m = [imageData length]/1024.0;
    if (m>10*1024) {
        [ALToastView toastInView:self.view withText:@"图片不能大于10M"];
        return nil;
    }
    
    imageData = UIImageJPEGRepresentation(image, 1/ (10 * m) );
    
    return imageData;
    
}

- (NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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

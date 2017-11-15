//
//  JQXChangePhotoController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXChangePhotoController.h"
#import "JQXChangePhotoCell.h"
@interface JQXChangePhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UILabel *tsLabel;
@property (nonatomic,strong)UILabel *countLabel;

@end

@implementation JQXChangePhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"商品图片" isBack:YES];
    
    [self.view addSubview:self.mainCollectionView];
     [self.mainCollectionView registerClass:[UICollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.mainCollectionView registerClass:[JQXChangePhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    [self setUpLongPressGes];
    [self setNavRightButton];
}
- (void)setNavRightButton
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(SCREEN_WIDTH-64, 0, 64, 44)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(CompleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:rightButton];
}
#pragma mark - 保存按钮点击事件
- (void)CompleteAction
{
    if(self.block !=nil){
        self.block(self.mainArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//block语句传值
- (void)photoArray:(JQXPhotoBlock)block
{
    self.block = block;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];

    if(!_mainScrollView){
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 180)];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        [header addSubview:_mainScrollView];
        
    }
    if(!_tsLabel){
        _tsLabel = [JQXCustom creatLabel:CGRectMake(0, self.mainScrollView.bottom + 10, SCREEN_WIDTH, 10) backColor:[UIColor clearColor] text:@"长按图片可拖动排序" textColor:[UIColor lightGrayColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [header addSubview:_tsLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _tsLabel.bottom + 10, SCREEN_WIDTH - 20, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [header addSubview:lineView];
    }
    if(!_countLabel){
        
        _countLabel = [JQXCustom creatLabel:CGRectMake((SCREEN_WIDTH - 20 - 50)/2, 140, 50, 30) backColor:[UIColor lightGrayColor] text:@"" textColor:[UIColor whiteColor] font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
        _countLabel.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:.3];
        _countLabel.hidden = YES;
        [header addSubview:_countLabel];
    }
    [self.mainScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(self.mainArray.count != 0){
        for (int i = 0; i < self.mainArray.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*(SCREEN_WIDTH-20), 0, SCREEN_WIDTH - 20, 180)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.mainArray[i]] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
            imageView.userInteractionEnabled = YES;
//            imageView.clipsToBounds = YES;
//            imageView.contentMode = UIViewContentModeScaleAspectFill;
            

            [self.mainScrollView addSubview:imageView];
            
            UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(imageView.width - 30, 0, 30, 30)];
            [deleteButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
            deleteButton.tag = 100 +i;
            [deleteButton addTarget:self action:@selector(DeleteAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:deleteButton];
            
        }
         self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *self.mainArray.count, 180);
    }
   
    if(self.mainArray.count != 0){
        self.countLabel.hidden = NO;
        self.countLabel.text = [NSString stringWithFormat:@"1/%ld",self.mainArray.count];
    }else{
        self.countLabel.hidden = YES;
    }
    return header;
}

#pragma mark -  重点的地方在这里 滚动时候进行计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView == self.mainScrollView){
        
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        self.countLabel.text = [NSString stringWithFormat:@"%d/%ld",page,self.mainArray.count];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 220);
}

#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.mainArray.count ==4){
        return 4;
    }else{
        return self.mainArray.count + 1;
    }
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQXChangePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.row < self.mainArray.count){
        
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:self.mainArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
        
    }else if(indexPath.row == self.mainArray.count){
        
        cell.headerImage.image = [UIImage imageNamed:@"photo"];
    }
    
    
    return cell;
}
//点击item事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == self.mainArray.count){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self choosePhotoAction];
        }];
        
        UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self choosePictureAction];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:photoAction];
        [alert addAction:pictureAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}
#pragma mark - 照片点击事件
- (void)choosePhotoAction
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.navigationBar.backgroundColor = [UIColor redColor];
    //判断设备是否支持这种sourcetype
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    ipc.delegate = self;
    //是否允许编辑
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - 相册点击事件
- (void)choosePictureAction
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.navigationBar.backgroundColor = [UIColor whiteColor];
    //判断设备是否支持这种sourcetype
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    ipc.delegate = self;
    //是否允许编辑
    ipc.allowsEditing = YES;
    
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark---ImagePickerControllerDelegate---
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    
    NSString *formatInfo = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
    
    if ([formatInfo rangeOfString:@"JPG"].location == NSNotFound &&
        [formatInfo rangeOfString:@"PNG"].location == NSNotFound) {
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [self uploadImage:originalImage];
        
        
    }
    
    //    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    //    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)upimage
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
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
        [JHHJView hideLoading];
        
        /*
         code = 200;
         count = 0;
         data = "https://ph-images.oss-cn-shenzhen.aliyuncs.com/merchant/app/image/20170727/20170727181025233761898.png";
         message = "\U56fe\U7247\U4e0a\U4f20\U6210\U529f";
         success = 1;
         */
        
        if([responseObject[@"code"]integerValue] == 200){
            NSString *dataStr = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
//            self.headImage.image = upimage;
            [self.mainArray addObject:dataStr];
            [ALToastView toastInView:self.view withText:@"上传成功"];
            [self.mainCollectionView reloadData];
            
        }else{
            [ALToastView toastInView:self.view withText:responseObject[@"message"]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [JHHJView hideLoading];
        NSLog(@"上传失败 %@", error);
        [ALToastView toastInView:self.view withText:@"请求失败"];
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
- (UICollectionView *)mainCollectionView
{
    if(!_mainCollectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 1.设置列间距
        layout.minimumInteritemSpacing = 10;
        // 2.设置行间距
        layout.minimumLineSpacing = 10;
        // 3.设置每个item的大小
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 50)/4, (SCREEN_WIDTH - 50)/4);
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, self.navBarView.bottom, SCREEN_WIDTH - 20, SCREEN_HEIGHT) collectionViewLayout:layout];
        _mainCollectionView.showsHorizontalScrollIndicator = YES;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        
    }
    return _mainCollectionView;
}
#pragma mark - 添加长按手势
- (void)setUpLongPressGes {
    UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    [self.mainCollectionView addGestureRecognizer:longPresssGes];
}

- (void)longPressMethod:(UILongPressGestureRecognizer *)longPressGes {
    
    // 判断手势状态
    switch (longPressGes.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            // 判断手势落点位置是否在路径上(长按cell时,显示对应cell的位置,如path = 1 - 0,即表示长按的是第1组第0个cell). 点击除了cell的其他地方皆显示为null
            NSIndexPath *indexPath = [self.mainCollectionView indexPathForItemAtPoint:[longPressGes locationInView:self.mainCollectionView]];
            // 如果点击的位置不是cell,break
            if (nil == indexPath) {
                break;
            }
            NSLog(@"%@",indexPath);
            // 在路径上则开始移动该路径上的cell
            [self.mainCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:{
            
            // 移动过程当中随时更新cell位置
            NSIndexPath *indexPath = [self.mainCollectionView indexPathForItemAtPoint:[longPressGes locationInView:self.mainCollectionView]];
            
            if(indexPath.row <self.mainArray.count){
                [self.mainCollectionView updateInteractiveMovementTargetPosition:[longPressGes locationInView:self.mainCollectionView]];
            }else{
                [self.mainCollectionView cancelInteractiveMovement];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            // 移动结束后关闭cell移动
            NSIndexPath *indexPath = [self.mainCollectionView indexPathForItemAtPoint:[longPressGes locationInView:self.mainCollectionView]];
            
            if(indexPath.row <self.mainArray.count){
                
                 [self.mainCollectionView endInteractiveMovement];
            }else{
                [self.mainCollectionView cancelInteractiveMovement];
            }
            break;
        }
        default:
            [self.mainCollectionView cancelInteractiveMovement];
            break;
    }
}
#pragma mark - 移动cell 数据源更改
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSLog(@"%ld         --------     %ld",sourceIndexPath.row,destinationIndexPath.row);
    
    if(destinationIndexPath.row < self.mainArray.count){
        NSString *imgStr = [NSString stringWithFormat:@"%@",[self.mainArray objectAtIndex:sourceIndexPath.row]];
        [self.mainArray removeObjectAtIndex:sourceIndexPath.row];
        [self.mainArray insertObject:imgStr atIndex:destinationIndexPath.row];
        dispatch_time_t delayTime = dispatch_time
        (DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
        
        dispatch_after
        (delayTime, dispatch_get_main_queue(),
         ^{
              [self.mainCollectionView reloadData];
             
             
         }
         );
        
       
    }
    
}
#pragma mark - 删除
- (void)DeleteAction:(UIButton *)sender
{
    NSInteger page = sender.tag - 100;
    [self.mainArray removeObjectAtIndex:page];
    
    [self.mainCollectionView reloadData];
    
}
- (NSMutableArray *)mainArray
{
    if(!_mainArray){
        _mainArray = [NSMutableArray array];
    }
    return _mainArray;
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

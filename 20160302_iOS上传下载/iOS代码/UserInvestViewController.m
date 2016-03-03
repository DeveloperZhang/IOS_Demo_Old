//
//  UserInvestViewController.m
//  inKer
//
//  Created by 杨志达 on 15-1-23.
//  Copyright (c) 2015年 Zhi Da Yang. All rights reserved.
//

#import "UserInvestViewController.h"

#import "SlideTabBar.h"

#import "YKBaoTableViewController.h"

#import "UserInvestTableViewController.h"

#import "GiftTalkSheetView.h"

#import "ShareManager.h"

#import <MobileCoreServices/UTCoreTypes.h>

#import "ShareEntity.h"
#import "YKInviteViewController.h"
#import "YKUserTypeMgr.h"
#import "YKExperienceGoldViewController.h"
#import "NSString+Hashing.h"

#define kType 2

@interface UserInvestViewController ()<UIScrollViewDelegate,SlideTabBarDelegate,GiftTalkSheetDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic,strong) SlideTabBar *stBar;

@property (nonatomic,strong) UIScrollView *tabScrollView;

@property (nonatomic,assign) BOOL leftSideShow;

@property (nonatomic,strong) YKBaoTableViewController   *ykbaoTableVC;

@property (nonatomic,strong) UserInvestTableViewController   *uiATVC;

@property (nonatomic,strong) UserInvestTableViewController   *uiBTVC;

@property (nonatomic,assign) BOOL isLoading;

//分享
@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong) NSArray *imageArray;

@property (nonatomic,strong) NSString *imgUrl;

@property (nonatomic,strong) NSString *cotent;

@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) NSString *invikeCode;

@end

@implementation UserInvestViewController

#pragma mark - view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mInit];
    [self mSubviewInit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNewTaskEvent:) name:KNOTIFICATION_EXPERIENCEGOLD_NEWTASK object:nil];
    
    
}

- (void)handleNewTaskEvent:(NSNotification *)notify
{
    NSString *userType = [[NSUserDefaults standardUserDefaults] objectForKey:KYKUserType];
    if ([userType integerValue] == 2) {
        YKExperienceGoldViewController *vc = [[YKExperienceGoldViewController alloc] initWithNibName:@"YKExperienceGoldViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([userType integerValue] == 1){
        YKInviteViewController *inviteVC = [[YKInviteViewController alloc] initWithNibName:@"YKInviteViewController" bundle:nil];
        [self.navigationController pushViewController:inviteVC animated:YES];
    }
}

#pragma mark - my init
- (void)mInit
{
    if (iOS_7_AND_LATER)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _isLoading = NO;
}

- (void)mSubviewInit
{
    [self navigationItemInit];
    
    [self tabScrollViewInit];
    
    [self slideTabInit];
}

- (void)navigationItemInit
{
    //背景色
    self.view.backgroundColor = COLOR_BACKGROUND_WHITE;
    
    //银客网LOGO
    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yk_logo"]];
    
    logoImgView.bounds = CGRectMake(0, 0, logoImgView.image.size.width, logoImgView.image.size.height);
    
    self.navigationItem.titleView = logoImgView;
    
    //推出侧栏按钮
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_side_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(menuBtn:)];
    
    self.navigationItem.leftBarButtonItem = menuBtn;
    
    //分享按钮
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right_side_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtn:)];
    
    self.navigationItem.rightBarButtonItem = shareBtn;
    
    _titleArray = @[@"微信好友",@"微信朋友圈",@"QQ",@"邮件",@"复制链接",@"信息"];
    
    _imageArray = @[@"invite_icon_chat_default",
                    @"invite_icon_friend_default",
                    @"invite_icon_qq_default",
                    @"invite_icon_mail_default",
                    @"invite_icon_link_default",
                    @"invite_icon_message_default"];
}

- (void)slideTabInit
{
    //    _stBar = [[SlideTabBar alloc] initWithTitles:@[@"银客宝",@"直投区",@"转让区"]];
    _stBar = [[SlideTabBar alloc] initWithTitles:@[@"投资区",@"转让区"]];
    
    if (iOS_7_AND_LATER)
    {
        _stBar.frame = CGRectMake(0, 64, SCREEN_WIDTH, 35);
    }
    else
    {
        _stBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
    }
    
    _stBar.normalColor = [UIColor darkGrayColor];
    
    _stBar.selectColor = COLOR_THEME_BLUE;
    
    _stBar.selectIndex = 0;
    
    _stBar.delegate = self;
    
    [self.view addSubview:_stBar];
}

- (void)tabScrollViewInit
{
    if (iOS_7_AND_LATER)
    {
        _tabScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 35, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 35)];
    }
    else
    {
        _tabScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH, SCREEN_HEIGHT - 35)];
    }
    
    _tabScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, _tabScrollView.frame.size.height);
    
    _tabScrollView.showsHorizontalScrollIndicator = NO;
    
    _tabScrollView.bounces = NO;
    
    _tabScrollView.pagingEnabled = YES;
    
    _tabScrollView.delegate = self;
    
    [_tabScrollView.panGestureRecognizer addTarget:self action:@selector(panTabView:)];
    
    [self.view addSubview:_tabScrollView];
    
    //银客宝
    _ykbaoTableVC = [[YKBaoTableViewController alloc] initWithNibName:@"YKBaoTableViewController" bundle:[NSBundle mainBundle]];
    
    [self addChildViewController:_ykbaoTableVC];
    
    [_tabScrollView addSubview:_ykbaoTableVC.view];
    
    //直投区
    _uiATVC = [[UserInvestTableViewController alloc] initWithNibName:@"UserInvestTableViewController" bundle:[NSBundle mainBundle]];
    
    _uiATVC.type = ProjectNormal;
    
    [self addChildViewController:_uiATVC];
    
    [_tabScrollView addSubview:_uiATVC.view];
    
    //转让区
    _uiBTVC = [[UserInvestTableViewController alloc] initWithNibName:@"UserInvestTableViewController" bundle:[NSBundle mainBundle]];
    
    _uiBTVC.type = ProjectTransfer;
    
    [self addChildViewController:_uiBTVC];
    
    [_tabScrollView addSubview:_uiBTVC.view];
    
    CGFloat vcHeight = _tabScrollView.frame.size.height;
    
    if (iOS_7_AND_LATER)
    {
        //        _ykbaoTableVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, vcHeight);
        //        _uiATVC.view.frame    = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, vcHeight);
        
        _uiATVC.view.frame    = CGRectMake(0, 0, SCREEN_WIDTH, vcHeight);
        _uiBTVC.view.frame  = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, vcHeight);
    }
    else
    {
        //        _ykbaoTableVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, vcHeight);
        //        _uiATVC.view.frame    = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH,vcHeight);
        
        _uiATVC.view.frame    = CGRectMake(0, 0, SCREEN_WIDTH,vcHeight);
        _uiBTVC.view.frame  = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, vcHeight);
    }
    
    //侧栏开关响应
    __weak UserInvestViewController *uiVC = self;
    
    [self.mm_drawerController setGestureCompletionBlock:^(MMDrawerController *drawerController, UIGestureRecognizer *gesture) {
        uiVC.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - selector
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _stBar.slideValue = _tabScrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _stBar.selectIndex = _tabScrollView.contentOffset.x/SCREEN_WIDTH;
}

- (void)panTabView:(UIPanGestureRecognizer *)pan
{
    if (self.mm_drawerController.visibleLeftDrawerWidth == 0)
    {
        CGPoint translation = [pan translationInView:self.view];
        
        if (translation.x > 0 && _tabScrollView.contentOffset.x == 0)
        {
            self.view.userInteractionEnabled = NO;
            
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        }
    }
}

- (void)slideTabBar:(SlideTabBar *)slideTabBar selectIndex:(NSInteger)index
{
    _tabScrollView.contentOffset = CGPointMake(_stBar.selectIndex * SCREEN_WIDTH, 0);
    
    switch (index)
    {
        case 0:
            //
            break;
            //        case 1:
            //        {
            //            if (_uiATVC.listArray.count == 0 && _isLoading == NO)
            //            {
            //                _isLoading = YES;
            //
            //                MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:_uiATVC.tableView];
            //
            //                _uiATVC.tableView.scrollEnabled = NO;
            //
            //                [_uiATVC.tableView addSubview:HUD];
            //
            //                [HUD show:YES];
            //
            //                [_uiATVC loadListCompletion:^(BOOL finished) {
            //
            //                    _isLoading = NO;
            //
            //                    _uiATVC.tableView.scrollEnabled = YES;
            //
            //                    [_uiATVC.tableView reloadData];
            //
            //                    [HUD hide:YES];
            //                }];
            //            }
            //            break;
            //        }
            //        case 2:
            //        {
            //            if (_uiBTVC.listArray.count == 0 && _isLoading == NO)
            //            {
            //                _isLoading = YES;
            //
            //                MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:_uiBTVC.tableView];
            //
            //                _uiBTVC.tableView.scrollEnabled = NO;
            //
            //                [_uiBTVC.tableView addSubview:HUD];
            //
            //                [HUD show:YES];
            //
            //                [_uiBTVC loadListCompletion:^(BOOL finished) {
            //
            //                    _isLoading = NO;
            //
            //                    _uiBTVC.tableView.scrollEnabled = YES;
            //
            //                    [_uiBTVC.tableView reloadData];
            //
            //                    [HUD hide:YES];
            //                }];
            //            }
            //
            //            break;
            //        }
            
        case 1:
        {
            if (_uiBTVC.listArray.count == 0 && _isLoading == NO)
            {
                _isLoading = YES;
                
                MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:_uiBTVC.tableView];
                
                _uiBTVC.tableView.scrollEnabled = NO;
                
                [_uiBTVC.tableView addSubview:HUD];
                
                [HUD show:YES];
                
                [_uiBTVC loadListCompletion:^(BOOL finished) {
                    
                    _isLoading = NO;
                    
                    _uiBTVC.tableView.scrollEnabled = YES;
                    
                    [_uiBTVC.tableView reloadData];
                    
                    [HUD hide:YES];
                }];
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)menuBtn:(UIBarButtonItem *)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - share
- (void)shareBtn:(UIBarButtonItem *)sender
{
    
//    //请求分享内容
//    
//    [ShareEntity shareWithCompleteBlock:^(ShareEntity *iaEntity, NSError *error) {
//        
//        _invikeCode = iaEntity.invikeCode;
//        ShareContentModel *model = iaEntity.model;
//        _imgUrl = model.imgUrl;
//        _cotent = model.cotent;
//        _url = model.url;
//        
//    }];
//    
//    GiftTalkSheetView *GiftTalk = [[GiftTalkSheetView alloc] initWithTitleArray:_titleArray ImageArray:_imageArray PointArray:nil ActivityName:nil Delegate:self];
//    [GiftTalk ShowInView:self.view];
    
//    [self upLoadFile];
    [self downloadTouched];
    
}

- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    
    //以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    //   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
    //
    //    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    //
    //    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    //    [request setHTTPMethod:@"POST"];
    //
    //    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:[NSString stringWithFormat:@"%@%@",savedPath,[requestURL MD5Hash]] append:NO]];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}


//使用
- (void)downloadTouched {
    NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSLog(@"%@",savedPath);
    [self downloadFileWithOption:@{@"userid":@"123123"}
                   withInferface:@"http://localhost:8080/FileOperaionDemo/DownLoadServlet"
                       savedPath:savedPath
                 downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

                 } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     
                 } progress:^(float progress) {
                     
                 }];
}

- (void)upLoadFile {
    UIImage *image = [UIImage imageNamed:@"guide_0"];
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    imageView.image = image;
    //    [self.view addSubview:imageView];
    [[AFHTTPClientUpload sharedClient] uploadImageWithUrl:@"/UploadServlet1" image:image success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
        NSLog(@"responseObject--->%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - Gift delegate

- (void)GiftTalkShareButtonAction:(NSInteger *)buttonIndex
{
    [self ShareButtonAction:buttonIndex];
}

-(void)ShareButtonAction:(NSInteger *)buttonIndex
{
    NSString *linkURL = [_url stringByAppendingString:[NSString stringWithFormat:@"?code=%@",_invikeCode]];
    if (_imgUrl == nil || _cotent == nil || _url == nil) {
        _imgUrl = @"shareImage.jpg";
        _cotent = @"发红包啦！有福利总要照顾下朋友，真的有钱能提现哦！";
        _url = @"http://www.yinker.com/wapReg.shtml";
        linkURL = _url;
    }
    
    
    switch ((int)buttonIndex) {
        case 0: //微信好友
        {
            [ShareManager registeShareOfType:WXshareType AndAppID:WXAppID];
            if (kType == 1) {
                //                [ShareManager sendImageWithImageName:imageName ImageType:kImageType ShreType:WXshareType ShareScene:SceneSession];
            }
            else if (kType == 2){
                [ShareManager sendLinkTitle:nil description:_cotent ImageName:_imgUrl URLAdd:linkURL Type:WXshareType ShareScene:SceneSession];
            }
        }
            break;
        case 1:  //微信朋友圈
        {
            [ShareManager registeShareOfType:WXshareType AndAppID:WXAppID];
            if (kType == 1) {
                //                [ShareManager sendImageWithImageName:imageName ImageType:kImageType ShreType:WXshareType ShareScene:SceneTimeline];
            }
            else if (kType == 2){
                [ShareManager sendLinkTitle:nil description:_cotent ImageName:_imgUrl URLAdd:linkURL Type:WXshareType ShareScene:SceneTimeline];
            }
            
        }
            break;
        case 2: //QQ
        {
            [ShareManager registeShareOfType:QQshareType AndAppID:QQAppID];
            [ShareManager sendLinkTitle:nil description:_cotent ImageName:_imgUrl URLAdd:linkURL Type:QQshareType ShareScene:SceneSession];
        }
            break;
        case 3: //邮件
        {
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                mc.mailComposeDelegate = self;
                [mc setSubject:_cotent];
                [mc setMessageBody:linkURL isHTML:YES];
                [self presentViewController:mc animated:YES completion:nil];
            }
            else
            {
                MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                [self.navigationController.view addSubview:HUD];
                HUD.mode = MBProgressHUDModeText;
                HUD.labelText = @"请先登录您的邮箱";
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
            }
            
        }
            break;
        case 4: //复制链接
        {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:linkURL];
            
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            
            [self.navigationController.view addSubview:HUD];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"复制成功";
            
            [HUD show:YES];
            
            [HUD hide:YES afterDelay:1];
        }
            break;
        case 5: //短信
        {
            if ([MFMessageComposeViewController canSendText])
            {
                [self sendSMS:_cotent urlAddress:linkURL];
            }
        }
            break;
    }
}

//message
- (void)sendSMS:(NSString *)bodyOfMessage urlAddress:(NSString *)address
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    
    if([MFMessageComposeViewController canSendText])
        
    {
        
        controller.body = [bodyOfMessage stringByAppendingString:[NSString stringWithFormat:@"来看看吧，地址是：%@",address]];
        
        
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    
}

//message回调
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:controller completion:nil ];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed");
    
}

//mail回调
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

#import <UIKit/UIKit.h>
#import "Sky.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect screen = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:screen];
    
    UIViewController *vc = [[UIViewController alloc] init];
    
    // 背景图
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:screen];
    bgView.image = [UIImage imageNamed:@"bg"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds = YES;
    [vc.view addSubview:bgView];
    [vc.view sendSubviewToBack:bgView];
    
    // 顶部标题【多语言】
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, screen.size.width - 40, 60)];
    titleLabel.text = NSLocalizedString(@"app_title", nil);
    titleLabel.font = [UIFont boldSystemFontOfSize:32];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [vc.view addSubview:titleLabel];
    
    // 提示文字【多语言】
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 250, 80)];
    label.text = NSLocalizedString(@"tip_text", nil);
    label.font = [UIFont systemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    [vc.view addSubview:label];
    
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(80, 320, 160, 50);
    [btn setTitle:NSLocalizedString(@"btn_start_float", nil) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:22];
    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:btn];
    
    //公告按钮
    UIButton *btnIcon = [UIButton buttonWithType:UIButtonTypeSystem];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnX = screenW - 160 - 80;
    btnIcon.frame = CGRectMake(btnX, 320, 160, 50);
    btnIcon.tag = 1001;
    
    // 设置图标
    UIImage *img = [UIImage imageNamed:@"gonggao_icon"];
    [btnIcon setImage:img forState:UIControlStateNormal];
    [btnIcon setTitle:NSLocalizedString(@"btn_notice", nil) forState:UIControlStateNormal];
    btnIcon.titleLabel.font = [UIFont systemFontOfSize:22];
    [btnIcon setTintColor:[UIColor whiteColor]];
    [btnIcon addTarget:self action:@selector(onClickBtnIcon:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:btnIcon];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)onClickBtn:(UIButton *)sender {
    NSLog(@"✅ 悬浮窗启动成功");
}

- (void)onClickBtnIcon:(UIButton *)sender {
    if (sender.tag == 1001) {
        // 全部读取本地化文本
        NSString *title = NSLocalizedString(@"notice_title", nil);
        NSString *content = NSLocalizedString(@"notice_content", nil);
        [self showNotice:title content:content];
    }
}

- (void)showNotice:(NSString *)title content:(NSString *)content {
    UIViewController *rootVC = self.window.rootViewController;
    CGRect screen = [UIScreen mainScreen].bounds;

    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = screen;
    blurView.tag = 999;
    [rootVC.view addSubview:blurView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlankClose:)];
    tap.cancelsTouchesInView = NO;
    blurView.userInteractionEnabled = YES;
    [blurView addGestureRecognizer:tap];
    
    UIView *popup = [[UIView alloc] initWithFrame:CGRectMake(40, 180, screen.size.width - 80, 280)];
    popup.backgroundColor = [UIColor colorWithWhite:1 alpha:0.85];
    popup.layer.cornerRadius = 16;
    popup.clipsToBounds = YES;
    [blurView.contentView addSubview:popup];
    
    UILabel *popTitle = [[UILabel alloc] initWithFrame:CGRectMake(20,20,popup.bounds.size.width-40,36)];
    popTitle.text = title;
    popTitle.font = [UIFont boldSystemFontOfSize:26];
    popTitle.textAlignment = NSTextAlignmentCenter;
    [popup addSubview:popTitle];
    
    UILabel *popText = [[UILabel alloc] initWithFrame:CGRectMake(20,70,popup.bounds.size.width-40,120)];
    popText.text = content;
    popText.font = [UIFont systemFontOfSize:18];
    popText.numberOfLines = 0;
    [popup addSubview:popText];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn.frame = CGRectMake(40, popup.bounds.size.height - 60, popup.bounds.size.width - 80, 44);
    [closeBtn setTitle:NSLocalizedString(@"btn_close", nil) forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [closeBtn addTarget:self action:@selector(closePopup:) forControlEvents:UIControlEventTouchUpInside];
    [popup addSubview:closeBtn];
}

- (void)closePopup:(UIButton *)sender {
    UIView *blurView = [self.window viewWithTag:999];
    if (blurView) {
        [blurView removeFromSuperview];
    }
}

- (void)tapBlankClose:(UITapGestureRecognizer *)tap
{
    UIView *blurView = [self.window viewWithTag:999];
    if (blurView) {
        [blurView removeFromSuperview];
    }
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
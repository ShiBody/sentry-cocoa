#import <Foundation/Foundation.h>

#if TARGET_OS_OSX

#    import "SentryCrash.h"
#    import "SentryCrashExceptionApplication.h"
#    import "SentryCrashExceptionApplicationHelper.h"
#    import "SentryDependencyContainer.h"
#    import "SentrySDK+Private.h"
#    import "SentrySDK.h"


//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         永无BUG
//
//
//


@implementation SentryCrashExceptionApplicationHelper

+ (void)reportException:(NSException *)exception
{
    SentryCrash *crash = SentryDependencyContainer.sharedInstance.crashReporter;
    if (nil != crash.uncaughtExceptionHandler && nil != exception) {
        crash.uncaughtExceptionHandler(exception);
    }
}

+ (void)_crashOnException:(NSException *)exception
{
    [SentrySDK captureCrashOnException:exception];
#    if !(SENTRY_TEST || SENTRY_TEST_CI)
    [SentrySDK flush:5.0];
//    abort();
#    endif
}

@end

#endif // TARGET_OS_OSX

//
//  SynthesizeSingleton.h
//  MsmChat
//
//  Created by 孟晓雄 on 16/8/19.
//  Copyright © 2016年 mengxx. All rights reserved.
//

#if __has_feature(objc_arc)

#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(classname) \
\
+ (classname *)shared##classname;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
static dispatch_once_t pred; \
dispatch_once(&pred, ^{ shared##classname = [[classname alloc] init]; }); \
return shared##classname; \
}

#else



#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(classname) \
\
+ (classname *)shared##classname;


/*

 公开单列
 
+(classname *)sharedMLoginManager;

 
 单列创建登录
 
static MLoginManager *sharedMLoginManager = nil;

+(MLoginManager *)shardMLoginManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        
        sharedMLoginManager = [[MLoginManager alloc] init];
    
    });
    
    return sharedMLoginManager;
}
*/




#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
static dispatch_once_t pred; \
dispatch_once(&pred, ^{ shared##classname = [[classname alloc] init]; }); \
return shared##classname; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return NSUIntegerMax; \
} \
\
- (oneway void)release \
{ \
} \
\
- (id)autorelease \
{ \
return self; \
}

#endif

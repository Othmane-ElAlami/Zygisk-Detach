#pragma once

#include <android/log.h>

#define LOGD(fmt, ...) \
    __android_log_print(ANDROID_LOG_DEBUG, "zygisk-detach", "[%d] " fmt, __LINE__, ##__VA_ARGS__)
// quick_example.cpp
#include <map>
#include <stdio.h>
#include <string>
#include <sstream>

uint32_t nextId = 0;
std::string challenge;
std::string response;

extern "C" {

    uint32_t test1(int num) {
        printf("Test1 called with %d", num);
        return 1;
    }

    const char* testBuffer(int width, int height, const char* buffer) {
        static std::string outString;
        printf("Test2 called with %dx%d and a buffer starting with %d", width, height, buffer[0]);
        std::ostringstream out;
        out << "Dimentions: " << width << " by " << height;
        outString = out.str();
        return outString.c_str();
    }

    const char* getVersion() {
        return VERSION;
    }
}

int main() {
    printf("Version: %s\n", getVersion());
}

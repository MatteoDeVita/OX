
#include "frameBufferHandler.h"

int main()
{
    
    frameBuffer_t frameBuffer = frameBuffer_create();

    frameBuffer.putC(&frameBuffer, 'D');
    frameBuffer.setFGColor(&frameBuffer, FB_CYAN);
    frameBuffer.setBGColor(&frameBuffer, FB_RED);
    frameBuffer.putC(&frameBuffer, 'E');
    return 0;
}
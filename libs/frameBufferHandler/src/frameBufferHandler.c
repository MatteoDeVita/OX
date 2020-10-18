/*
** Personnal PROJECT, 2020
** OX
** File description:
** frameBufferHandler
*/


#include "frameBufferHandler.h"

// void disp_c(char c) {
//     char *tt = (char *) 0x000B8000;
//     tt[0] = c;
//     tt[1] = 0x28;
// }


frameBuffer_t frameBuffer_create(void) {
    frameBuffer_t this;

    this._ptr = (char *) 0x000B8000;
    this._current_index = 0;
    this._fgColor = 0x2;
    this._bgColor = 0x8;
    this.putC = _frameBuffer_putC;
    this.setBGColor = _frameBuffer_setBGColor;
    this.setFGColor = _frameBuffer_setFGColor;
    return this;
}

frameBuffer_t *new_frameBuffer(void) {
    // frameBuffer_t *this;
    return ((void *)0);
}


void _frameBuffer_putC(frameBuffer_t *this, const char c)
{
    this->_ptr[this->_current_index++] = c;
    this->_ptr[this->_current_index++] = ((this->_fgColor & 0x0F) << 4) | (this->_bgColor & 0x0F);
}

void _frameBuffer_setBGColor(frameBuffer_t *this, frameBufferColors_t color)
{
    this->_bgColor = color;
}

void _frameBuffer_setFGColor(frameBuffer_t *this, frameBufferColors_t color)
{
    this->_fgColor = color;
}
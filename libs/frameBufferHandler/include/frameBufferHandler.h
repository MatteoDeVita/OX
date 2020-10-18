/*
** Personnal PROJECT, 2020
** OX
** File description:
** frameBufferHandler
*/

#pragma once

/*
*   frameBufferColors enumeration : used to describe frameBuffer colors
*/
typedef enum frameBufferColors {
    FB_BLACK = 0,
    FB_BLUE,
    FB_GREEN,
    FB_CYAN,
    FB_RED,
    FB_MAGENTA,
    FB_BROWN,
    FB_LIGHT_GREY,
    FB_DARK_GREY,
    FB_LIGHT_BLUE,
    FB_LIGHT_GREEN,
    FB_LIGHT_CYAN,
    FB_LIGHT_RED,
    FB_LIGHT_MAGENTA,
    FB_LIGHT_BROWN,
    FB_WHITE
} frameBufferColors_t;

/*
*   frameBuffer structure : used for I/O operations on frameBuffer
*/
typedef struct frameBuffer {
    //public:
   
    /*
    *   Print character in the next available cell.
    *
    *   @param  this    Instance of frameBuffer
    *   @param  c       character to be printed
    */
    void (*putC)(struct frameBuffer *this, const char c);

    /*
    *   Set background color for the next characters that will be printed.
    *   This function don't change the whole frameBuffer background color.
    * 
    *   @param  this    Instance of frameBuffer
    *   @param  bgColor Background color
    */
    void (*setBGColor)(struct frameBuffer *this, frameBufferColors_t color);
  
   /*
    *   Set foreground color for the next characters that will be printed.
    *   This function don't change the whole frameBuffer background color.
    * 
    *   @param  this    Instance of frameBuffer
    *   @param  bgColor Foreground color
    */
    void (*setFGColor)(struct frameBuffer *this, frameBufferColors_t color);

    //private:
    char *_ptr;
    int _current_index;
    char _colors;
    frameBufferColors_t _fgColor;
    frameBufferColors_t _bgColor;
} frameBuffer_t;

/*
    Create and returns an initialized frameBuffer structure
*/
frameBuffer_t frameBuffer_create(void);

/*
    Create and returns an initialized frameBuffer structure
    poiners.
    !!! You should not use this function for now because memory
    management is not yet implemented
*/
frameBuffer_t *new_frameBuffer(void);

void _frameBuffer_putC(frameBuffer_t *this, const char c);
void _frameBuffer_setBGColor(frameBuffer_t *this, frameBufferColors_t color);
void _frameBuffer_setFGColor(frameBuffer_t *this, frameBufferColors_t color);

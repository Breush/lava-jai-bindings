// Compiled with:
// gcc libxcbglue.c -c -fPIC -lxcb -o libxcbglue.o
// gcc libxcbglue.o -shared -o libxcbglue.so

#include <xcb/xcb.h>

// @note Can't make that work in Jai directly using the binding, so I had to make this tool function.
xcb_screen_t* xcb_setup_get_screen(xcb_setup_t* setup, int screenIndex) {
    if (screenIndex < 0) return 0;

    xcb_screen_iterator_t iter = xcb_setup_roots_iterator(setup);

    while (screenIndex-- > 0) {
        xcb_screen_next(&iter);
    }

    xcb_screen_t* screen = iter.data;
    return screen;
}

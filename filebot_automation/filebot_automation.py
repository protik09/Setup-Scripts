#! /bin/env/python

"""
This is the script that will run in Staging Area using FileBot. It will rename all the TV Shows
using TheTVDB and grab subtitles from OpenSubtitles.

It first grabs all media and subtitle files from their respective torrent folders, pulls them out to
the Staging Area, downloads subtitles for them and then renames as per my media naming convention.

@author: Protik Banerji
"""

import os
import sys
import colorama as cm
import pyfiglet as pf
import termcolor as tc

cm.init(strip=(not sys.stdout.isatty()))  # strip colors if stdout is redirected


def Banner(
    input_string_="Banner",
    fore_ground_="white",
    back_ground_="on_grey",
    banner_font_="ogre",
):
    """

    Nice banner on the top of the calling program.
    A full list of fonts can be found at U{http://www.figlet.org/fontdb.cgi}

    @param input_string_: The string to be displayed on the banner.
    @type input_string_: string
    @param fore_ground_: The font color to be used.
    @type fore_ground_: string
    @param back_ground_: The color of the banner.
    @type back_ground_: string
    @param banner_font_: The font to be used on the banner.
    @type banner_font_: string

    @author: Protik Banerji U{<protik09@gmail.com> <mailto:protik09@gmail.com>}
    """
    # Checking to see if arguments are the correct figlet_format
    fore_ground_ = fore_ground_.lower()
    back_ground_ = back_ground_.lower()
    banner_font_ = banner_font_.lower()
    tc.cprint(
        pf.figlet_format(input_string_, font=banner_font_),
        fore_ground_,
        back_ground_,
        attrs=["bold"],
    )

    return


if __name__ == "__main__":
    Banner("Automatic Media Organizer")

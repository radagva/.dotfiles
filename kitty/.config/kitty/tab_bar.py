# ~/.config/kitty/tab_bar.py

import datetime

from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:

    # Color palette
    COLOR_WHITE = as_rgb(int("C4746E", 16))
    COLOR_DIM = as_rgb(int("625E5A", 16))  # Dimmed slate gray
    COLOR_DATETIME = as_rgb(int("8A9A7B", 16))  # Mauve accent

    # Keep the entire bar background transparent/default
    screen.cursor.bg = 0

    # Apply styling based on tab state
    if tab.is_active:
        screen.cursor.fg = COLOR_WHITE
        screen.cursor.bold = False
        screen.cursor.italic = False
        title_text = f" {tab.title[:max_title_length]} "
    else:
        screen.cursor.fg = COLOR_DIM
        screen.cursor.bold = False
        screen.cursor.italic = False
        title_text = f" {tab.title[:max_title_length]} "

    # Draw the tab title
    screen.draw(title_text)

    # Save the position where the tabs end
    end = screen.cursor.x

    # Handle the right-aligned datetime on the last tab
    if is_last:
        now = datetime.datetime.now().strftime("%b %a %d, %H:%M ")
        status_length = len(now)
        start_of_status = screen.columns - status_length

        if start_of_status > end:
            # Calculate and draw the transparent padding gap
            padding = " " * (start_of_status - end)
            screen.cursor.bg = 0
            screen.draw(padding)

            # Style and draw the clock
            screen.cursor.fg = COLOR_DATETIME
            screen.cursor.bg = 0
            screen.cursor.bold = False
            screen.cursor.italic = False
            screen.draw(now)

    return end

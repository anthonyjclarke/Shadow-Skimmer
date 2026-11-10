"""The hull map of Shadow Skimmer, drawn by the game's own code.

skool2html loads this class with `-c Config/HtmlWriterClass=src:screens.ScreenWriter`
(see the Makefile). It adds one method for the #CALL macro. Each screen is drawn
by #DRAWSCREEN, the macro that src/shadskim.ref defines in [Config] Expand and
that every screen render in the listing uses: it runs the game's screen clear and
its screen entry in SkoolKit's simulator. This method only tiles the play areas
the simulator leaves in the display file into one image.
"""

from skoolkit.graphics import Frame
from skoolkit.skoolhtml import HtmlWriter

# The hull map is 10 screens across and 11 down, and a screen's play area is
# rows 6-23 of the display, 32 cells across.
MAP_COLUMNS = 10
MAP_ROWS = 11
PLAY_TOP = 6
PLAY_WIDTH = 32
PLAY_HEIGHT = 18


class ScreenWriter(HtmlWriter):
    def hull_map(self, cwd, fname, scale=1):
        """#CALL(hull_map(fname[,scale])): every outer hull screen, tiled in
        hull map order, with the map's top-left screen at the top left."""
        tiles = []
        for row in range(MAP_ROWS):
            band = [[] for _ in range(PLAY_HEIGHT)]
            for column in range(MAP_COLUMNS):
                self.push_snapshot()
                self.expand('#DRAWSCREEN({},{},0)'.format(column, row), cwd)
                play_area = self.screenshot(0, PLAY_TOP, PLAY_WIDTH, PLAY_HEIGHT)
                self.pop_snapshot()
                for y, udgs in enumerate(play_area):
                    band[y].extend(udgs)
            tiles.extend(band)
        frame = Frame(tiles, scale)
        return self.handle_image(frame, fname, cwd, path_id='ScreenshotImagePath')

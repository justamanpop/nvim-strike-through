# nvim-cross-off
Very minimal neovim plugin that:
- toggles strikes through for current line of text if in normal mode
- toggles strikes through for selected text if in visual mode

E.g:
hello world -> h̶e̶l̶l̶o̶ ̶w̶o̶r̶l̶d̶

s̶t̶r̶i̶k̶e̶d̶ ̶t̶h̶r̶o̶u̶g̶h̶ ̶t̶e̶x̶t̶ -> striked through text

If selected text or current line has some struck through text and some normal text, converts entire line into normal non struck through text

Functions and mappings:
- Exposes two functions ToggleStrikeThrough (to toggle current line in normal mode) and ToggleStrikeThroughVisual (to toggle visual selection)
- Sets up a default mapping of <leader><C-o> (think cross off) for ToggleStrikeThrough in normal mode and ToggleStrikeThroughVisual in visual and block visual mode


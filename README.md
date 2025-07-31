# strike-through.nvim

Very minimal neovim plugin that is used to toggle the strike through effect on text.

It achieves this by adding a long stroke overlay unicode (U+0336) after each character

- toggles strikes through effect for current line of text if in normal mode
- toggles strikes through for selected text if in visual mode

## Showcase

If in normal mode, toggles strike through on current line of text (toggle is triggered using default keymap of <leader>co)
TODO - add video

If in visual mode, toggles strike through on selected text
TODO - add video

> [!INFO]
> If selected text or current line has some strike-through text and some normal-text, converts entire line into non strike through text
TODO - add video

## Installation

```
require("lazy").setup({
    "justamanpop/strike-through.nvim"
})
```

## Functions and mappings:

- Exposes two functions ToggleStrikeThrough (to toggle current line in normal mode) and ToggleStrikeThroughVisual (to toggle visual selection)
- Sets up a default mapping of "<leader>co" (co =  cross off) for ToggleStrikeThrough in normal mode and ToggleStrikeThroughVisual in visual and block visual mode

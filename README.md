# strike-through.nvim

Very minimal neovim plugin that is used to toggle the strike through effect on text.

It achieves this by adding a long stroke overlay unicode (U+0336) after each character

- toggles strikes through effect for current line of text if in normal mode
- toggles strikes through for selected text if in visual mode

## Showcase

If in normal mode, toggles strike through on current line of text (toggle is triggered using default keymap of \<leader\>co)

https://github.com/user-attachments/assets/a71114b3-3028-4f46-905f-546645475c35


If in visual mode, toggles strike through on selected text (does not work as expected for visual block mode)


https://github.com/user-attachments/assets/962e7ae5-12b0-4497-9c1e-30e986651836




If selected text or current line has some strike-through text and some normal-text, converts entire line into non strike through text


https://github.com/user-attachments/assets/b43eaa03-a890-4b43-9c2e-fc3317b0c824


## Installation

```
require("lazy").setup({
    "justamanpop/strike-through.nvim"
})
```

## Functions and mappings:

- Exposes two functions ToggleStrikeThrough (to toggle current line in normal mode) and ToggleStrikeThroughVisual (to toggle visual selection)
- Sets up a default mapping of "<leader>co" (co =  cross off) for ToggleStrikeThrough in normal mode and ToggleStrikeThroughVisual in visual and block visual mode

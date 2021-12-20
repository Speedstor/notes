# Vim Cheatsheet

- [Vim Cheatsheet](#vim-cheatsheet)
  - [turns out i didn't know how to use vim](#turns-out-i-didnt-know-how-to-use-vim)
  - [skips in the same line](#skips-in-the-same-line)
  - [scrolling](#scrolling)
  - [operators](#operators)
  - [deleting](#deleting)
  - [windows/tabs](#windowstabs)
  - [options](#options)
  - [cursor](#cursor)
  - [`g` commands](#g-commands)
  - [Manipulating Numbers](#manipulating-numbers)
    - [regex search and replace](#regex-search-and-replace)
<br/>
<br/>
<br/>

#### turns out i didn't know how to use vim
- `w` - move forward to the next word                       -> my `alt+f`
- `b` - move back to the previous word                      -> my `alt+w`
- `0` - move to the beginning of the current line           -> my `alt+a`
- `^` - move to the first non-blank character               -> my `home`
- `$` - move to the end of the current line                 -> my `alt+e`
- `%` - move to the matching bracket
- `A` - INSERT at the end of the line
- `I` - INSERT at the start of line after blanks
- `a` - INSERT after the character

#### skips in the same line
- `f<character>` **- skip** to the next chracter after the cursor
- `F<character>` - skip to the last character before the cursor
- `t<character>` - move to a character after the cursor
- `T<character>` **- move** to a character before your cursor
- BONUS!! - repeats
  - `;` to go forward repeat
  - `,` to go backward repeat

#### scrolling
- `ctrl+e` - scroll downwards without moving cursor         -> my `ctrl+down`
- `ctrl+y` - scroll upwards without moving cursor         -> my `ctrl+up`

#### operators
- `d` - delete
- `c` - change
- `y` - yank
- `p` - paste downwards
- `P` - paste upwards

#### deleting
- `D` - delete from cursor to the end of line, same w/ `d$`
- `dgg` - delete from cursor to the beginning of file
- `ggdG` - delete everything in the file
  
- `diw` - `d`elete `i`nside `w`word
- `ciw` - `diw` and put in INSERT mode
- `dip` - delete whole paragraph (paragraphs are seperated by two \n)

#### windows/tabs
- `:tabnew` or `:tabe` - open a new tab
- `:tabclose` or `:tabc` - close current tab
- `:tabonly` or `:tabo` - close every other tab except current one
- `gt` - go to the next tab
- `gT` - go to the previous tab

#### options
- `:set no<option>` - unset option
- `:set <option>!` - toggle option
- `:set <option>?` - return the option setted value
- `:set <option>&` - reset the option to default
- Ex.
  - `:set filetype? `

#### cursor
- `ctrl+o` - go to previous cursor history (undo cursor)        -> my `ctrl+u`
- `ctrl+i` - next cursor history (redo cursor)

#### `g` commands
- `ctrl+w ctrl+f` - open filepath under the cursor
- `gi` - move to last insertion location and INSERT
- `gv` - move to last VISUAL selection and VISUAL mode
- `gn` - **select** the match of the last search
- `gI` - move to very beginning of line ignoring blanks charcters
- `ga` - show hex, number of the character under cursor
- `gu` - switch character under cursor to lowercase
- `gU` - switch character under cursor to uppercase

#### Manipulating Numbers
- `ctrl+a` - increase the *first digit* or number on the line
- `ctrl+x` - decrease the *first digit* or number on the line
- `g ctrl+a` - same w/ `ctrl+a` but works in visual mode
- `g ctrl+x` - same w/ `ctrl+x` but works in visual mode

#### regex search and replace
*still need to learn*
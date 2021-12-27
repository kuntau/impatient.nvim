Experiential fork of [impatient.nvim](https://github.com/lewis6991/impatient.nvim) using [sqlite.lua](https://github.com/tami5/sqlite.lua).

Should be plug and play with sqlite.lua installed.

More information see source: https://github.com/lewis6991/impatient.nvim#readme

## Is it faster?

You mean faster then reading from filesystem? Yes! :D. On my system:

#### Pre-Cache

| Using  | Resolve    | Load       | Total      |
| ------ | ---------- | ---------- | ---------- |
| sqlite |  10.3255ms |  13.4365ms |  23.7620ms |
| normal |  11.1190ms |  16.1774ms |  27.2964ms |

#### Post-Cache

| Using  | Resolve    | Load       | Total      |
| ------ | ---------- | ---------- | ---------- |
| sqlite |  1.0132ms  |  2.6771ms  |   3.6903ms |
| normal |  0.9234ms  |  6.5058ms  |   7.4292ms |


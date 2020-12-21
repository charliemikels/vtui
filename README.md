Heads up, I recently discovered that V's built in `term` module basically already
does what this project was intended to do with `term.ui`.
See the docs for it [here](https://modules.vlang.io/term.ui.html)

# VTUI

A basic terminal UI system for the V programing language. This is a small hobby
project. (Right now,) stuff might and will change on the fly and without warning.

![](README_assets/demo.png)

Styled after [bpytop](https://github.com/aristocratos/bpytop).

## How do I install it?

Theoretically, these commands should automatically install and update this module
```bash
v install charliemikels.vtui
```
or
```bash
vpkg get github.com/charliemikels/vtui
```

Then you can update it with.
```bash
v update
```

If you want to do it manually, just clone this repo to `~/.vmodules/charliemikels/vtui` (or wherever your V modules are stored) and you should have the same experience. 

## How do I use vtui?

```v
import charliemikels.vtui

// The rest of your code here...
```

See the example directory for the code in action.

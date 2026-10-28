# welcome

**One capability bit from GBT V8, packaged standalone.** No. 291 of 341,
`system` domain (System).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **启动欢迎语**（主人令 2026-10-10：「启动APP数字人的欢迎语，你来看看说什么，要有 GBT小土豆V8 和 开发者：自由的风，其他你来想要有未来感的语言」）。文字是**单一真源**（gbt_allinone/welcome.py 的 WELCOME；必含项由 check() 机械咬住）。三个 op：text 取全文+必含项判据 · audio 预生成音频的落点与状态 · boot 启动用**一次给全**（显示什么 + 播哪个文件）。🔴 音频**必须预生成**：本机 TTS 走 CPU，约 **150 倍慢于实时**（实测 2.36 秒用 327 秒）⇒ 启动时现造要等几十分钟；造一次缓存到盘，启动直接播；**没造就如实报**，界面退化成只显示文字 —— 不许静默、不许假装播了。只读零作用域。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-welcome.git
cd gbt-welcome
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_welcome info                  # capability card
python -m gbt_welcome spec --json           # machine-readable contract
python -m gbt_welcome check --payload '{}'
python -m gbt_welcome run   --payload '{}'
```

Real `info` output from this machine:

```text
welcome  (system)  v1.0.0
----------------------------------------
**启动欢迎语**（主人令 2026-10-10：「启动APP数字人的欢迎语，你来看看说什么，要有 GBT小土豆V8 和 开发者：自由的风，其他你来想要有未来感的语言」）。文字是**单一真源**（gbt_allinone/welcome.py 的 WELCOME；必含项由 check() 机械咬住）。三个 op：text 取全文+必含项判据 · audio 预生成音频的落点与状态 · boot 启动用**一次给全**（显示什么 + 播哪个文件）。🔴 音频**必须预生成**：本机 TTS 走 CPU，约 **150 倍慢于实时**（实测 2.36 秒用 327 秒）⇒ 启动时现造要等几十分钟；造一次缓存到盘，启动直接播；**没造就如实报**，界面退化成只显示文字 —— 不许静默、不许假装播了。只读零作用域。

gated      : False
external   : False
multi-op   : False
params     : (none)
```

Wire a real implementation:

```python
from gbt_welcome import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.13s
```

## Provenance

| field | value |
|---|---|
| capability | `welcome` |
| domain | `system` |
| handler | `welcome` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [system/welcome](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/system/welcome.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.

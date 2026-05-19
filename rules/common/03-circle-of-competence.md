# 3. Circle of Competence

> "Risk comes from not knowing what you're doing."
> — Warren Buffett

> "Know what you own, and know why you own it."
> — Peter Lynch

## Why

The size of your circle of competence is not the issue. The honesty about its perimeter is.

Most blow-ups happen outside the perimeter — in instruments the operator never modeled in stress, on venues whose halt rules they never read, on names whose business they cannot explain in three sentences.

An agent has the same problem with sharper edges: it will happily reason about anything you put in its context window, including names it has no real signal on.

## Checklist

- [ ] The universe of tradable instruments is *whitelisted* — not "anything the broker lists".
- [ ] For each instrument, the bot can answer: what drives the price, who else trades it, what halts it.
- [ ] When a new instrument is requested, it must clear an explicit onboarding (data history, liquidity floor, tick size, halt rules) before the bot can trade it.
- [ ] Edge cases the bot has *not* been tested against (illiquid microcaps, pre-IPO, suspended-then-resumed names, ETFs in disposition) are blocked by default.
- [ ] "I don't know" is a valid action and is preferred to a low-conviction trade.

## How an AI trading bot enforces this

```python
TRADABLE_UNIVERSE = load_whitelist("config/universe.yaml")  # tickers + reason + last review date

def in_circle(ticker):
    if ticker not in TRADABLE_UNIVERSE:
        return False
    entry = TRADABLE_UNIVERSE[ticker]
    if days_since(entry.last_review) > 90:
        return False                      # stale: needs human re-review
    if entry.avg_daily_value_krw < 1_000_000_000:  # 10억 floor, example
        return False
    return True
```

The bot is not allowed to "explore" outside the circle in production. Exploration happens in research mode, against a paper account, with results reviewed before promotion.

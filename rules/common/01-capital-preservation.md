# 1. Capital Preservation First

> "Rule No. 1: Never lose money. Rule No. 2: Never forget rule No. 1."
> — Warren Buffett

## Why

A 50% drawdown requires a 100% gain to break even. A 75% drawdown requires 300%. Arithmetic, not opinion.

The first job of an agent that touches capital is not to make money. It is to not permanently impair it. Returns compound; permanent losses compound the other way.

This is the parent of every other rule. Margin of safety, position sizing, cycle awareness, behavioral discipline — they all exist to keep this one from being broken.

## Checklist (must pass before any order is sent)

- [ ] Worst-case loss per position is bounded (hard stop or option-defined risk).
- [ ] Worst-case loss per day, week, and month is bounded at the portfolio level.
- [ ] No single trade can take the account below a pre-declared `min_equity_floor`.
- [ ] Leverage, if any, is explicit and reversible without a forced sale.
- [ ] Drawdown breaker: when realized + open loss exceeds the daily cap, all new entries are blocked until a human resets.
- [ ] "Catastrophic but plausible" scenario (gap-down at open, exchange halt, broker outage) has a written response.

## How an AI trading bot enforces this

```python
# pre_trade_guard.py
def can_open(order, portfolio, risk_config):
    if portfolio.realized_today + portfolio.unrealized_open <= -risk_config.daily_loss_cap:
        return Reject("daily_loss_cap breached")
    if order.worst_case_loss_krw > risk_config.per_trade_loss_cap:
        return Reject("per_trade_loss_cap breached")
    if portfolio.equity_after(order) < risk_config.min_equity_floor:
        return Reject("min_equity_floor breached")
    return Allow()
```

Capital preservation is a precondition, not a preference. If the guard cannot prove the trade is safe, the trade does not exist.

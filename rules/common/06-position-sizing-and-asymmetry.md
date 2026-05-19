# 6. Position Sizing and Asymmetric Risk-Reward

> "It takes courage to be a pig. … When you see it, bet big."
> — Stanley Druckenmiller

> "The way to build long-term returns is through preservation of capital and home runs. … When you have tremendous conviction on a trade, you have to go for the jugular."
> — Stanley Druckenmiller

## Why

Returns are not the average of your trades. They are the *path* of your trades through a sized portfolio. A 90% win rate with bad sizing loses; a 40% win rate with right sizing compounds.

Asymmetry is the only thing that matters at the trade level: how much you make when right vs how much you lose when wrong. Sizing is the only thing that matters at the portfolio level: how much of the account is on each asymmetric bet.

A bot that sizes uniformly across signals is throwing away its own edge. A bot that sizes on conviction without bounding downside is one tail event from blowing up.

## Checklist

- [ ] Every entry has a written reward/risk ratio. Minimum threshold (e.g., 2:1) is enforced in code.
- [ ] Position size is a function of: per-trade risk, conviction, regime, current portfolio heat — not a fixed lot.
- [ ] Size is computed from the *stop distance*, not the position notional ("risk 0.5% per trade", not "buy 100 shares").
- [ ] No single position exceeds a hard cap (e.g., 10% of equity for cash equities, lower for leveraged products).
- [ ] Correlated positions share a single risk budget (don't get sized as if independent when they aren't).

## How an AI trading bot enforces this

```python
def size_position(equity, stop_distance_pct, conviction, regime):
    risk_per_trade = 0.005 * equity        # 0.5% account risk per trade
    base_qty_krw = risk_per_trade / stop_distance_pct
    conviction_mult = clamp(conviction, 0.5, 2.0)   # 0.5..2.0
    regime_mult = REGIME_MULT[regime]
    notional = base_qty_krw * conviction_mult * regime_mult
    return min(notional, 0.10 * equity)    # 10% hard cap per name

def asymmetry_ok(entry, target, stop):
    reward = abs(target - entry)
    risk   = abs(entry - stop)
    return risk > 0 and (reward / risk) >= 2.0
```

The bot only "bets big" inside guardrails that were drawn before the trade was thought of.

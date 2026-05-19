# 5. Cycles and Reflexivity

> "Rule number one: most things will prove to be cyclical. Rule number two: some of the greatest opportunities for gain and loss come when other people forget rule number one."
> — Howard Marks

> "Every bubble has two components: an underlying trend that prevails in reality and a misconception relating to that trend. When a positive feedback develops between the trend and the misconception, a boom-bust process is set in motion."
> — George Soros, on reflexivity

## Why

Markets are not random walks around a stable fundamental. Prices change perceptions; perceptions change behavior; behavior changes fundamentals — and the loop runs both ways.

An agent that ignores cycles will buy peaks (because everything is going up) and sell troughs (because everything is going down). It will treat the most dangerous environment as the safest, because the recent variance is the lowest.

The fix is not to predict the cycle. It is to know where on the cycle you currently are, and to refuse to act as if it is somewhere else.

## Checklist

- [ ] The bot tracks at least one cycle proxy per market it trades (credit spreads, VIX/VKOSPI, breadth, IPO activity, retail margin balances).
- [ ] Position-size multipliers scale *down* in late-cycle/euphoric regimes and *up* in fear regimes — not the reverse.
- [ ] The bot has a written definition of "regime change" and the data conditions that trigger it.
- [ ] When a reflexive feedback loop is detected (price → narrative → flow → price), the bot tightens stops and reduces gross exposure.
- [ ] Backtests are stratified by regime; a strategy that only worked in one regime is treated as one-regime only.

## How an AI trading bot enforces this

```python
def regime_adjusted_size(base_size, regime):
    table = {
        "fear":      1.25,   # contrarian add
        "neutral":   1.00,
        "greed":     0.60,
        "euphoria":  0.25,   # near-zero, not zero — leave a stub to keep the model honest
    }
    return base_size * table[regime.label]

def detect_reflexivity(price_series, narrative_score, flow_series):
    # crude positive-feedback detector
    return (corr(price_series, narrative_score, lag=5) > 0.7
            and corr(narrative_score, flow_series, lag=2) > 0.7)
```

Predicting the top is optional. Refusing to act as if there is no top is mandatory.
